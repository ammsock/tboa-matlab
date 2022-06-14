function dT = diff_temp(obj,temp,cs,vf)

  dT = obj.diff_temp_prec(temp,cs,vf);
  % if strcmp(obj.variant,'prec') == 1
  %   dT = obj.diff_temp_prec(temp,cs,vf);
  % elseif strcmp(obj.variant,'prec_eq') == 1
  %   dT = obj.diff_temp_prec(temp,cs,vf);
  % elseif strcmp(obj.variant,'orig') == 1
  %   dT = obj.diff_temp_orig(temp,cs,cf);
  % else
  %   error('diff_temp does not support obj.variant.')
  % end
end
