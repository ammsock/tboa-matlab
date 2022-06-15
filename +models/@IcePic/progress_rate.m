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
