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

function qr = progress_rate_prec(obj,temp,cs)

  if obj.isotherm()
    persistent fwd bwd
    if isempty(fwd)
      fwd = obj.forward_rate(temp(1));
    end
    if isempty(bwd)
      bwd = obj.backward_rate(temp(1));
    end
  else
    fwd = obj.forward_rate(temp);
    bwd = obj.backward_rate(temp);
  end

  persistent tb_reacs tb_coeffs
  if isempty(tb_reacs)
    tb_reacs = [4,5,6];
    tb_coeffs = [2.5,1,1,1,12,1;
                 2.5,1,1,1,12,1;
                 2.5,1,1,1,12,1];
  end
  cM = tb_coeffs*cs;

  persistent nu_fwd nu_bwd
  if isempty(nu_fwd)
    %       reac-id: 1 2 3 4 5 6
    nu_fwd = sparse([1,1,0,1,0,0; ...  % H2
                     0,0,0,0,1,1; ...  % H
                     1,0,1,0,1,0; ...  % O
                     0,1,0,0,0,1; ...  % OH
                     0,0,1,0,0,0; ...  % H2O
                     0,0,0,0,0,0]);    % N2

    %       reac-id: 1 2 3 4 5 6
    nu_bwd = sparse([0,0,0,0,0,0; ...  % H2
                     1,1,0,2,0,0; ...  % H
                     0,0,0,0,0,0; ...  % O
                     1,0,2,0,1,0; ...  % OH
                     0,1,0,0,0,1; ...  % H2O
                     0,0,0,0,0,0]);    % N2
  end

  % Calculate cs product in qr formula
  cs_prod_fwd = zeros(size(nu_fwd,2),size(cs,2));
  cs_prod_bwd = zeros(size(nu_bwd,2),size(cs,2));
  for k=1:size(cs,2)
    cs_prod_fwd(:,k) = prod(cs(:,k).^nu_fwd)';
    cs_prod_bwd(:,k) = prod(cs(:,k).^nu_bwd)';
  end

  % Calculate pre-progress rate
  qr = cs_prod_fwd.*fwd - cs_prod_bwd.*bwd;

  % Functional style (less efficient)
  % colmatpow = @(cs,nu) splitapply(@(c) prod(c.^nu)',cs,1:size(cs,2));
  % qr = colmatpow(cs,nu_fwd).*fwd - colmatpow(cs,nu_bwd).*bwd;

  % Multiply with third body concentration
  qr(tb_reacs,:) = cM.*qr(tb_reacs,:);

  % qr = [fwd(1,:).*cs(3,:).*cs(1,:)-bwd(1,:).*cs(2,:).*cs(4,:); ...
  %       fwd(2,:).*cs(1,:).*cs(4,:)-bwd(2,:).*cs(5,:).*cs(2,:); ...
  %       fwd(3,:).*cs(3,:).*cs(5,:)-bwd(3,:).*cs(4,:).^2; ...
  %       cM.*(fwd(4,:).*cs(1,:)-bwd(4,:).*cs(2,:).^2); ...
  %       cM.*(fwd(5,:).*cs(3,:).*cs(2,:)-bwd(5,:).*cs(4,:)); ...
  %       cM.*(fwd(6,:).*cs(2,:).*cs(4,:)-bwd(6,:).*cs(5,:))];
end
