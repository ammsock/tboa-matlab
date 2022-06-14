function [lambda,mu,nu] = ftle(obj,ts,vs,ws)
  arguments
    obj
    ts
    vs
    ws = zeros(0,length(ts))
  end

  vspeeds = obj.length(vs);
  wspeeds = obj.length(ws);

  lambda = get_lambda(obj,ts,vspeeds);
  mu = get_lambda(obj,ts,wspeeds,@min);
  nu = get_nu(ts,lambda,mu);
end


function lambda = get_lambda(obj,ts,vspeeds,cs_comp)
  arguments
    obj
    ts
    vspeeds
    cs_comp = @max
  end

  if isempty(vspeeds)
    lambda = zeros(0,length(ts));
    return
  end

  nv = size(vspeeds,1);

  lambda.speeds = vspeeds./vspeeds(:,ts==0);
  % lambda.speeds_back = vspeeds./vspeeds(:,end);
  lambda.speeds_back = vspeeds;
  lambda.exps = log(lambda.speeds(:,ts~=0))./ts(ts~=0);

  try
    lambda.exp = lambda.exps(:,end);
  catch
    size(lambda.exps)
  end

  lambda.cs = zeros(nv,length(ts));
  for k=1:length(ts)
    lambda.cs(:,k) = cs_comp(cs_comp(lambda.speeds_back(:,k:end)...
                                     ./lambda.speeds_back(:,k),[],1)...
                             ./exp((ts(k:end)-ts(k))*cs_comp(lambda.exp)),[],2);
  end

  lambda.c = lambda.cs(:,ts==0);

  lambda.dcs = log(lambda.cs(ts~=0)./lambda.c)./ts(ts~=0);
  lambda.dc = max(abs(lambda.dcs),[],2);
end


function nu = get_nu(ts,lambda,mu)
  nu.exps = -min(mu.exps,[],1)-min(lambda.exps,[],1);
  nu.speeds = 1./(min(mu.speeds,[],1).*min(lambda.speeds,[],1));
  nu.speeds_back = 1./(min(mu.speeds_back,[],1).*min(lambda.speeds_back,[],1));
  nu.exp = nu.exps(end);

  nu.cs = zeros(1,length(ts));
  for k=1:length(ts)
    nu.cs(k) = ...
      max(nu.speeds_back(k:end)./nu.speeds_back(k)./exp((ts(k:end)-ts(k))*nu.exp),[],2);
  end

  nu.c = nu.cs(ts==0);

  nu.dcs = log(nu.cs(ts~=0)/nu.c)./ts(ts~=0);
  nu.dc = max(abs(nu.dcs));
end
