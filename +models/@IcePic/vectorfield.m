%  Copyright (C) 2022 Jörn Dietrich
%  ----------------------------------------------------------------------------
% This file is part of AMMSoCK.
%
% AMMSoCK is free software: you can redistribute it and/or modify it under the
% terms of the GNU General Public License as published by the Free Software
% Foundation, either version 3 of the License, or (at your option) any later
% version. AMMSoCK is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
% FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
% details. You should have received a copy of the GNU General Public License
% along with AMMSoCK. If not, see <https://www.gnu.org/licenses/>.

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
