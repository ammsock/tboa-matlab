function [fval,expl] = tboa_objfun(obj,tspan,p0,v0)
  arguments
    obj
    tspan
    p0
    v0 = obj.velocity(p0)
  end

  w0 = null(v0');

  [ts,ps,vs,ws] = obj.simulate(tspan,p0,v0,w0);
  [lambda,mu,nu] = obj.ftle(ts,vs,ws);

  % fval = nu.dc;
  % fval = max(log(nu.cs)-abs(nu.exp)*ts(2:end));
  % fval = max(abs(log(nu.cs/nu.c)./ts)+nu.exp);    % compatible with paper
  fval = max(abs(log(nu.cs/nu.cs(end))./(ts(end)-ts))+nu.exp);    % compatible with paper (optimized?)
  % fval = nu.exps(1);
  % fval = min(log(nu.cs)+abs(nu.exp)*ts(2:end));
  % fval = max(max(log(nu.cs)-abs(nu.exp)*ts(2:end)),min(log(nu.cs)+abs(nu.exp)*ts(2:end)));
  expl = '';
end
