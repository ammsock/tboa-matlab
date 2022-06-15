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

function p0 = rand_init_val(obj,num,xrange,yrange,zrange)
  arguments
    obj
    num = 1
    xrange = [-1,1]
    yrange = [-1,1]
    zrange = [-1,1]
  end

  ranges=[xrange;yrange;zrange];
  c0s = [];

  for k=1:num
    c0=-1;
    while any(c0 < 0)
      c0 = (null(obj.tboa_Aeq(:,2:end))*(ranges(:,1)+diff(ranges,[],2).*rand(3,1))+obj.tboa_Aeq(:,2:end)\obj.tboa_beq);
    end
    c0s = [c0s,c0];
  end

  if obj.isotherm
    p0 = [repmat(obj.T,1,size(c0s,2));c0s];
  elseif obj.adiabatic
    p0 = [obj.get_temp(c0s,obj.h);c0s];
  end
end
