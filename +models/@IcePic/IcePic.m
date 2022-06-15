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

classdef IcePic < Model
  properties
    % isotherm = true
    % isobar = true
    % adiabatic = false
    variant = 'prec'
    name = 'ice-pic model'
    pdim = 7
    vdim = 6

    T = 1200
    h = 0

    % beq = 1e0*1e-3*[1.25;4.15e-1;6.64]      % lebiedz_sisc_2013

    % lb = [0,0,0,0,0,0,0]
    species = {'H2' 'H' 'O' 'OH' 'H2O' 'N2'}

    onb = [ 0.654653670707977                   0                   0;
           -0.436435780471985   0.816496580927726                   0;
            0.436435780471985   0.408248290463863   0.408248290463863;
                            0                   0  -0.816496580927726;
           -0.436435780471985  -0.408248290463863   0.408248290463863;
                            0                   0                   0];
  end

  methods
    function obj = IcePic(T,h)
      obj.T = T;
      if nargin > 1
        obj.h = h;
      end
      obj.tboa_Aeq = 1e1*[0,2,1,0,1,2,0;  % H
                          0,0,0,1,1,1,0;  % O
                          0,0,0,0,0,0,2]; % N
      obj.tboa_beq = 1e1*[1.2358118;4.116028e-1;6.59066];
    end

    function res = isotherm(obj)
      res = obj.T > 0;
    end

    function res = adiabatic(obj)
      res = obj.h > 0;
    end

    function dvfs = diff_velocity(obj,p,vs)
      % dvfs = [zeros(1,size(vs,2));obj.jacobian(p)*vs(2:end,:)];
      dvfs = obj.jacobian(p)*vs;
    end

    function cdvfs = codiff_velocity(obj,p,ws)
      % cdvfs = [zeros(1,size(ws,2));-obj.jacobian(p)'*ws(2:end,:)];
      cdvfs = -obj.jacobian(p)'*ws;
    end

    function [c,ceq] = tboa_nonlcon(obj,epsilon,tspan,p);
      [~,ps] = obj.simulate(tspan,p);

      c = -ps(:,end);
      ceq = 1e-5*(obj.local_speed(ps(:,end))-epsilon);
    end

    function m = mass(obj,ps)
      m = vecnorm(obj.Aeq*ps,1);
    end

    function v = velocity(obj,p)
      vf = obj.vectorfield(p);
      v = vf(2:end,:);
    end

    function p_proj = project(obj,p)
      p_proj = obj.onb'*p(2:end,:);
    end

    jac = jacobian(obj,p)
    bwd = backward_rate_exp_expand(obj,temp)
    bwd = backward_rate(obj,temp)
    bwd = backward_rate_orig(obj,temp)
    bwd = backward_rate_prec(obj,temp)
    dT = diff_temp(obj,temp,cs,vf)
    dT = diff_temp_orig(obj,temp,cs,vf)
    h = enthalpy(obj,temp,cs)
    K = equilibrium_constant(obj,temp)
    K = equilibrium_constant_orig(obj,temp)
    K = equilibrium_constant_prec_exp_expand(obj,temp)
    K = equilibrium_constant_prec(obj,temp)
    fwd = forward_rate(obj,temp)
    fwd = forward_rate_orig(obj,temp)
    fwd = forward_rate_prec(obj,temp)
    T = get_temp(obj,cs,h)
    x0 = get_x0_rand(obj,conserved)
    p0 = rand_init_val(obj,num,xrange,yrange)
    qr = progress_rate(obj,temp,cs)
    qr = progress_rate_no_bwd(obj,temp,cs)
    qr = progress_rate_orig(obj,temp,cs)
    qr = progress_rate_prec_eq(obj,temp,cs)
    qr = progress_rate_prec(obj,temp,cs)
    dqr = diff_progress_rate(obj,temp,cs)
    h = specific_enthalpy(obj,temp,cs)
    vf = vectorfield(obj,p)
    vf = vf_orig(obj,temp,cs)
    vf = vf_prec(obj,temp,cs)
    vf = vf_sorted(obj,temp,cs)
    vf = vf_sorted_qr(obj,temp,cs)
    ceq = conservation_law(obj,p)

    plot_projected(obj,tspan,num,p0)
  end
end
