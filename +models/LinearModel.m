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

classdef LinearModel
  properties
    gamma = 5
  end
  methods
    function obj = LinearModel(gamma)
      if nargin == 1
        obj.gamma = gamma;
      end
    end

    function v = vf(obj,x,y)
      v = [(-1-obj.gamma/2)*x + obj.gamma/2*y;
        obj.gamma/2*x + (-1-obj.gamma/2)*y];
    end

    function y = sim(obj,x)
      y = x;
    end
  end
end
