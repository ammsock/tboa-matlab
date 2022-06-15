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

function [ts,xs] = radau(obj,tspan,x0)

  options = odeset('BDF','on');

  if obj.isotherm
    [ts,cs] = ode15s(@(t,c) obj.vectorfield(x0(1),c), tspan, x0(2:end), options);
    Ts = x0(1)*ones(size(ts));
    xs = [Ts, cs];

  elseif obj.adiabatic
    [ts,xs] = ode15s(@(t,x) obj.vectorfield(x(1),x(2:end)), tspan, x0, options);
  end
end
