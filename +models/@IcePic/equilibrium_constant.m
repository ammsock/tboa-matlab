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

function K = equilibrium_constant(obj,temp)

  if strcmp(obj.variant,'prec') == 1
    K = obj.equilibrium_constant_prec(temp);
  elseif strcmp(obj.variant,'prec_eq') == 1
    K = obj.equilibrium_constant_prec_exp_expand(temp);
  elseif strcmp(obj.variant,'orig') == 1
    K = obj.equilibrium_constant_orig(temp);
  else
    error('equilibrium_constant: unsupported obj.variant:')
    error(obj.variant)
  end
end
