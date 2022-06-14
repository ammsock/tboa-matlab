function K = equilibrium_constant(obj,temp)

  if strcmp(obj.variant,'prec') == 1
    K = obj.equilibrium_constant_prec(temp);
  elseif strcmp(obj.variant,'prec_eq') == 1
    K = obj.equilibrium_constant_prec_exp_expand(temp);
  elseif strcmp(obj.variant,'orig') == 1
    K = obj.equilibrium_constant_orig(temp);
  else
    error('equilibrium_constant: unsupported obj.variant:')
    error(obj.variant)
  end
end
