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

function vf = vf_prec(obj,temp,cs)

  qr = obj.progress_rate(temp,cs);

  nu = [-1,-1,0,-1,0,0; % H2
        1,1,0,2,-1,-1;  % H
        -1,0,-1,0,-1,0; % O
        1,-1,2,0,1,-1;  % OH
        0,1,-1,0,0,1;   % H20
        0,0,0,0,0,0];   % N2

  vf = nu*qr;

  % vf = [-qr(1,:)-qr(2,:)-qr(4,:);
  %       +qr(1,:)+qr(2,:)+2*qr(4,:)-qr(5,:)-qr(6,:);
  %       -qr(1,:)-qr(3,:)-qr(5,:);
  %       +qr(1,:)-qr(2,:)+2*qr(3,:)+qr(5,:)-qr(6,:);
  %       +qr(2,:)-qr(3,:)+qr(6,:);
  %       0.0];
end



