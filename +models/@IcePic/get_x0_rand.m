function x0 = get_x0_rand(obj,conserved)

  c0 = -1;
  while any(c0 < 0)
    c0 = (null(obj.Aeq(:,2:end))*2.0*(rand(3,1)-0.5)+obj.Aeq(:,2:end)\obj.beq);
  end

  if obj.isotherm
    x0 = [conserved;c0];
  elseif obj.adiabatic
    x0 = [obj.get_temp(c0,conserved);c0];
  end
end
