function fwd = forward_rate(obj,temp)

  if strcmp(obj.variant,'prec') == 1
    fwd = obj.forward_rate_prec(temp);
  elseif strcmp(obj.variant,'prec_eq') == 1
    fwd = obj.forward_rate_prec(temp);
  elseif strcmp(obj.variant,'orig') == 1
    fwd = obj.forward_rate_orig(temp);
  else
    error(strcat('obj.variant  ',obj.variant,' not supported!'))
  end
end
