function bwd = backward_rate(obj,temp)

  if strcmp(obj.variant,'prec') == 1
    bwd = obj.backward_rate_prec(temp);
  elseif strcmp(obj.variant,'prec_eq') == 1
    bwd = obj.backward_rate_prec(temp);
  elseif strcmp(obj.variant,'orig') == 1
    bwd = obj.backward_rate_orig(temp);
  else
    error('backward_rate: Unsupported obj.variant:')
    error(obj.variant)
  end
end
