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

function len = speed_at_point(obj,p)
  % len = zeros(size(x,1),1);

  % disp('speed_at_point')
  vf = obj.vectorfield(p);
  if obj.adiabatic
    len = vecnorm(vf(2:end,:),2);
  else
    len = vecnorm(vf,2);
  end

  % for k=1:size(x,1)
  %   vf = obj.vectorfield(x(k,:));
  %   len(k) = norm(vf(2:end),2);
  % end
end
