function vf = vectorfield(obj,p)

  % if (size(p,2) == 1)
  %   p = p';
  % % else
  % %   disp(size(p))
  % end

  vf = zeros(size(p));
  vf(2:end,:) = obj.vf_prec(p(1,:),p(2:end,:));
  % if strcmp(obj.variant,'prec') == 1
  %   vf(:,2:end) = obj.vf_sorted(p(:,1),p(:,2:end));
  % elseif strcmp(obj.variant,'prec_eq') == 1
  %   vf(:,2:end) = obj.vf_sorted(p(:,1),p(:,2:end));
  % elseif strcmp(obj.variant,'orig') == 1
  %   vf(:,2:end) = obj.vf_orig(p(:,1),p(:,2:end));
  % else
  %   error('vectorfield: obj.variant not supported:')
  %   error(obj.variant)
  % end

  if obj.adiabatic
    vf(1,:) = obj.diff_temp(p(1,:),p(2:end,:),vf(2:end,:));
  end
end
