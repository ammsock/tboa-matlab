function ceq = conservation_law(obj,x)
  % if obj.isotherm
  if obj.isotherm()
    ceq = x(1)-obj.T;
  elseif obj.adiabatic()
    ceq = obj.specific_enthalpy(x(1),x(2:end))-h;
  end
end
