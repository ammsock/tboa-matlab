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

classdef DavisSkodje < Model
  properties
    name = 'Davis-Skodje model'
    pdim = 2
    vdim = 2
    gamma = 5
  end
  methods
    function obj = DavisSkodje(gamma)
      if nargin == 1
        obj.gamma = gamma;
      end
    end

    function vf = vectorfield(obj,p)
      vf = [-p(1,:); ...
        -obj.gamma*p(2,:)+...
        (p(1,:).*(obj.gamma*(p(1,:)+1)-1))./(1+p(1,:)).^2];
    end

    function jac = jacobian(obj,p)
      jac = [-1,  0; ...
        ((obj.gamma+1)*p(1)+obj.gamma-1)/(p(1)+1)^3, -obj.gamma];
    end

    function p0 = rand_init_val(obj,num,xrange,yrange)
      arguments
        obj
        num = 1
        xrange = [-1,10]
        yrange = [-5,5]
      end
      p0 = [xrange(1);yrange(1)]+[diff(xrange);diff(yrange)].*rand(obj.pdim,num);
    end

    function y = sim(obj,x)
      y = x./(x+1);
    end

    function phi = flow(obj,ts,p)
      phi = [p(1)*exp(-ts);
        p(1)./(p(1)+exp(ts)) + (p(2)-p(1)/(p(1)+1))*exp(-obj.gamma*ts)];
    end

    function dphi = dflow(obj,ts,p)
      % ps = obj.flow(ts,p);
      dphi = [exp(-ts), 0;
              exp(ts)/(exp(ts)+p(1))^2-exp(-obj.gamma*ts)/(p(1)+1)^2, exp(-obj.gamma*ts)];
      % dphi = [v(1)*exp(-ts);
      %   v(1)*exp(ts)/(exp(ts)+p(1)).^2+exp(-obj.gamma*ts)*(v(2)-v(1)/(p(1)+1)^2)];
      % dphi = [v(1)*(exp(-ts)+exp(ts)/(exp(ts)+p(1)).^2-exp(-obj.gamma*ts)/(p(1)+1)^2);
      %   exp(-obj.gamma*ts)*v(2)];
    end
  end
end
