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

classdef Model
  properties (Abstract)
    name
    pdim
    vdim
  end

  properties
    tboa_A   = []
    tboa_b   = []
    tboa_Aeq = []
    tboa_beq = []
    tboa_lb  = []
    tboa_ub  = []
  end

  methods (Abstract)
    vf = vectorfield(obj,p)
    jac = jacobian(obj,p)
    p0 = rand_init_val(obj,num,xrange,yrange)
  end

  methods
    [lambda,mu,nu] = ftle(obj,ts,ps,vs,ws)
    [ts,ps,vs,ws] = simulate(obj,tspan,p0,v0,w0)
    [fval,expl] = tboa_objfun(obj,tspan,p0,v0)
    [p,fval,exitflag] = tboa(obj,objfun,nonlcon,p0)

    plot_velocity(obj,x,y)
    plot_trajectories(obj,tspan,p0)
    plot_speed(obj,tspan,p0,v0)
    plot_first_variation(obj,ts,p0,v0)
    plot_ftle_over_time(obj,tspan,p0,v0)
    plot_ftles(obj,tfs,x,y)
    plot_normal_attractivity(obj,tspan,p0)

    function varargout = ode(varargin)
      options = odeset('RelTol',1e-5,'AbsTol',1e-10);
      [varargout{1:nargout}] = ode45(varargin{2:end},options);
    end

    function dvfs = diff_velocity(obj,p,vs)
      dvfs = obj.jacobian(p)*vs;
    end

    function cdvfs = codiff_velocity(obj,p,ws)
      if (isempty(ws))
        cdvfs = [];
      else
        cdvfs = -obj.jacobian(p)'*ws;
      end
    end

    % Returns the length of a vector v
    function len = length(obj,v)
      nrows = size(v,1)/obj.vdim;
      for k=1:nrows
        len(k,:) = vecnorm(v(((k-1)*obj.vdim+1):(k*obj.vdim),:),2);
      end
    end

    % Returns the length of the velocity vector at a point p
    function sp = local_speed(obj,p)
      sp = obj.length(obj.velocity(p));
    end

    % Returns the nonlinear constraints of TBOA
    function [c,ceq] = tboa_nonlcon(obj,epsilon,tspan,p0)
      [~,ps] = obj.simulate(tspan,p0);

      c = [];
      ceq = obj.tboa_nonlcon_eq(ps(:,end))-epsilon;
    end

    % Returns the value of the defining function of the equality contraint of TBOA
    function ceq = tboa_nonlcon_eq(obj,p)
      ceq = obj.local_speed(p);
    end

    function v = velocity(obj,p)
      v = obj.vectorfield(p);
    end
  end
end
