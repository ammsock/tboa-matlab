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

function x0 = get_x0_rand(obj,conserved)

  c0 = -1;
  while any(c0 < 0)
    c0 = (null(obj.Aeq(:,2:end))*2.0*(rand(3,1)-0.5)+obj.Aeq(:,2:end)\obj.beq);
  end

  if obj.isotherm
    x0 = [conserved;c0];
  elseif obj.adiabatic
    x0 = [obj.get_temp(c0,conserved);c0];
  end
end
