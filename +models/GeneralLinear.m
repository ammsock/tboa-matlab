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

classdef GeneralLinear < Model
  properties
    name = 'Linear Model'
    A
    pdim
    vdim
  end
  methods
    function obj = GeneralLinear(A)
      obj.A = A;
      obj.pdim = size(A,1);
      obj.vdim = obj.pdim;
    end

    function vf = vectorfield(obj,p)
      vf = obj.A*p;
    end

    function jac = jacobian(obj,p)
      jac = obj.A;
    end

    function p0 = rand_init_val(obj,num,xrange,yrange)
      arguments
        obj
        num = 1
        xrange = [-5,5]
        yrange = [-5,5]
      end
      p0 = [xrange(1);yrange(1)]+[diff(xrange);diff(yrange)].*rand(obj.pdim,num);
    end

    function mu = ftle_adj(obj,tf,p0,v0)
      mu = log(norm(expm(-tf*obj.A')*v0,2)/norm(v0,2))/tf;
    end
  end
end
