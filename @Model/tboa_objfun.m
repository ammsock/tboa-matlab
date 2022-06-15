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

function [fval,expl] = tboa_objfun(obj,tspan,p0,v0)
  arguments
    obj
    tspan
    p0
    v0 = obj.velocity(p0)
  end

  w0 = null(v0');

  [ts,ps,vs,ws] = obj.simulate(tspan,p0,v0,w0);
  [lambda,mu,nu] = obj.ftle(ts,vs,ws);

  % fval = nu.dc;
  % fval = max(log(nu.cs)-abs(nu.exp)*ts(2:end));
  % fval = max(abs(log(nu.cs/nu.c)./ts)+nu.exp);    % compatible with paper
  fval = max(abs(log(nu.cs/nu.cs(end))./(ts(end)-ts))+nu.exp);    % compatible with paper (optimized?)
  % fval = nu.exps(1);
  % fval = min(log(nu.cs)+abs(nu.exp)*ts(2:end));
  % fval = max(max(log(nu.cs)-abs(nu.exp)*ts(2:end)),min(log(nu.cs)+abs(nu.exp)*ts(2:end)));
  expl = '';
end
