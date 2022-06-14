function [lambda,mu,nu] = ftln(obj,ts,vs,ws)
  arguments
    obj
    ts
    vs
    ws = zeros(0,length(ts))
  end

  lambda = get_lambda(ts,vs,obj.dim);

  mu = get_lambda(ts,ws,obj.dim,@min);

  nu = get_nu(ts,lambda,mu);

end


function lambda = get_lambda(ts,vs,dim,cs_comp)
  arguments
    ts
    vs
    dim = size(vs,1)
    cs_comp = @max
  end

  if isempty(vs)
    lambda = zeros(0,length(ts));
    return
  end

  nv = size(vs,1)/dim;

  lambda.exps = zeros(nv,length(ts)-1);
  for k=1:nv
    lambda.exps(k,:) = log(vecnorm(vs(((k-1)*dim+1):(k*dim),2:end),2)/...
      norm(vs(((k-1)*dim+1):(k*dim),1),2))./ts(2:end);
  end

  lambda.exp = lambda.exps(:,end);

  lambda.cs = zeros(nv,length(ts)-1);
  for k=1:length(ts)-1
    lambda.cs(:,k) = exp(cs_comp(ts((k+1):end).*lambda.exps(:,k:end)-(ts((k+1):end)-ts(k)).*lambda.exp,[],2));
  end
  lambda.cs = lambda.cs./exp(ts(2:end).*lambda.exps);

  lambda.c = lambda.cs(:,1);

  lambda.dcs = [diff(lambda.cs,1,2)./diff(ts(2:end))./lambda.cs(:,1:(end-1))];
  lambda.dc = max(abs(lambda.dcs));

end


function nu = get_nu(ts,lambda,mu)
  nu.exps = -min(mu.exps,[],1)-min(lambda.exps,[],1);
  nu.exp = nu.exps(end);

  nu.cs = zeros(1,length(ts)-1);
  for k=1:length(ts)-1
    nu.cs(k) = exp(max(ts((k+1):end).*nu.exps(k:end)-(ts((k+1):end)-ts(k)).*nu.exp,[],2));
  end
  nu.cs = nu.cs./exp(ts(2:end).*nu.exps);

  nu.c = nu.cs(1);

  nu.dcs = [0,diff(nu.cs)./diff(ts(2:end))./nu.cs(1:(end-1))];%(nu.cs-nu.c)./ts;
  nu.dc = max(abs(nu.dcs));
end
