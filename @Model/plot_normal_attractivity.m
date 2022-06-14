function plot_normal_attractivity(obj,tspan,p0)

  v0 = obj.vectorfield(p0);

  for i=1:size(p0,2)
    w0 = null(v0(:,i));
    [ts,ps,vs,ws] = obj.simulate(tspan,p0,v0(:,i),w0);
  end

  lambda = 
end
