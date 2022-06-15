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

function jac = jacobian(obj,p);

  dqr = obj.diff_progress_rate(p(1),p(2:end));

  nu = [-1,-1,0,-1,0,0;
        1,1,0,2,-1,-1;
        -1,0,-1,0,-1,0;
        1,-1,2,0,1,-1;
        0,1,-1,0,0,1;
        0,0,0,0,0,0];

  jac = nu'*dqr;

end

