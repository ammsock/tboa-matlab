function T = get_temp(obj,cs,h)
  T = fzero(@(temp) obj.enthalpy(temp, cs) - h, 1000);
end
