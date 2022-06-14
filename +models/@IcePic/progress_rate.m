function qr = progress_rate(obj,temp,cs)

  qr = obj.progress_rate_prec(temp,cs);

  % if strcmp(obj.variant,'prec') == 1
  %   qr = obj.progress_rate_prec(temp,cs);
  % elseif strcmp(obj.variant,'prec_eq') == 1
  %   qr = obj.progress_rate_prec_eq(temp,cs);
  % elseif strcmp(obj.variant,'orig') == 1
  %   qr = obj.progress_rate_orig(temp,cs);
  % else 
  %   error('progress_rate: Unsupported obj.variant:')
  %   error(obj.variant)
  % end
end
