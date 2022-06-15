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
