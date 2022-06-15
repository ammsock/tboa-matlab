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

function plot_velocity(obj,x,y)
  if nargin < 3
    reso = 10;
    x = linspace(-5,5,reso);
    y = linspace(-5,5,reso);
  end

  [X,Y] = meshgrid(x,y);

  U = zeros(size(X));
  V = zeros(size(Y));

  for i=1:length(x)
    for j=1:length(y)
      p = [X(i,j);Y(i,j)];
      vf = obj.velocity(p);
      U(i,j) = vf(1);
      V(i,j) = vf(2);
    end
  end

  quiver(X,Y,U,V)
  title(sprintf('%s: vectorfield',obj.name))
end
