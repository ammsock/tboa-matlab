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

function qr = progress_rate_no_bwd(obj,temp,cs)

  fwd = obj.forward_rate(temp);
  K = obj.equilibrium_constant(temp);

  cM = 2.5*cs(1)+cs(2)+cs(3)+cs(4)+12*cs(5)+cs(6);

  qr = [fwd(1)*(cs(3)*cs(1)-cs(2)*cs(4)/K(1));
        fwd(2)*(cs(1)*cs(4)-cs(5)*cs(2)/K(2));
        fwd(3)*(cs(3)*cs(5)-cs(4)^2/K(3));
        cM*fwd(4)*(cs(1)-cs(2)^2/K(4));
        cM*fwd(5)*(cs(3)*cs(2)-cs(4)/K(5));
        cM*fwd(6)*(cs(2)*cs(4)-cs(5)/K(6))];
end
