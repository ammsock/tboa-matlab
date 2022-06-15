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

function [p_sol,fval,exitflag] = tboa(obj,objfun,nonlcon,p0)
  arguments
    obj
    objfun = @(p) obj.tboa_objfun([0,1],p)
    nonlcon = @(p) obj.tboa_nonlcon(1,[0,1],p)
    p0 = obj.rand_init_val()
  end

  options = optimoptions('fmincon','Display','iter' ...
                        ... % ,'Algorithm','sqp' ...
                        ,'StepTolerance',1e-15 ...
                        ... % ,'MaxFunEvals',50000 ...
                        ... % ,'TolX',1e-10 ...
                        ... % ,'TolCon',1e-6 ...
                        );

  %,'Algorithm','sqp');%,'MaxFunEvals',50000);
  [p_sol,fval,exitflag] = fmincon(objfun, p0, ...
                                  obj.tboa_A, obj.tboa_b, ...
                                  obj.tboa_Aeq, obj.tboa_beq, ...
                                  obj.tboa_lb, obj.tboa_ub, ...
                                  nonlcon, ...
                                  options);
end
