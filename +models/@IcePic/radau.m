function [ts,xs] = radau(obj,tspan,x0)

  options = odeset('BDF','on');

  if obj.isotherm
    [ts,cs] = ode15s(@(t,c) obj.vectorfield(x0(1),c), tspan, x0(2:end), options);
    Ts = x0(1)*ones(size(ts));
    xs = [Ts, cs];

  elseif obj.adiabatic
    [ts,xs] = ode15s(@(t,x) obj.vectorfield(x(1),x(2:end)), tspan, x0, options);
  end
end
