function dqr = diff_progress_rate(obj,temp,c)

  if obj.isotherm()
    persistent fwd bwd
    if isempty(fwd)
      fwd = obj.forward_rate(temp);
    end
    if isempty(bwd)
      bwd = obj.backward_rate(temp);
    end
  else
    fwd = obj.forward_rate(temp);
    bwd = obj.backward_rate(temp);
  end

  tb_reacs = [4,5,6];
  tb_coeffs = [2.5,1,1,1,12,1;
               2.5,1,1,1,12,1;
               2.5,1,1,1,12,1];

  cM = tb_coeffs*c;

  persistent nu_fwd nu_bwd
  if isempty(nu_fwd)
    %       reac-id: 1 2 3 4 5 6
    nu_fwd = sparse([1,1,0,1,0,0; ... % H2
                     0,0,0,0,1,1; ... % H
                     1,0,1,0,1,0; ... % O
                     0,1,0,0,0,1; ... % OH
                     0,0,1,0,0,0; ... % H2O
                     0,0,0,0,0,0]);   % N2

    %       reac-id: 1 2 3 4 5 6
    nu_bwd = sparse([0,0,0,0,0,0; ... % H2
                     1,1,0,2,0,0; ... % H
                     0,0,0,0,0,0; ... % O
                     1,0,2,0,1,0; ... % OH
                     0,1,0,0,0,1; ... % H2O
                     0,0,0,0,0,0]);   % N2
  end

  dnu = @(nu,k) nu-((1:size(nu,1))'==k);

  dnu_fwd = @(k) dnu(nu_fwd,k);
  dnu_bwd = @(k) dnu(nu_bwd,k);

  qr = obj.progress_rate(temp,c);

  dqr = zeros(size(nu_fwd));
  for k=1:size(nu_fwd,1)
    dqr(:,k) = nu_fwd(k,:)'.*prod(c.^dnu_fwd(k))'.*fwd ...
              -nu_bwd(k,:)'.*prod(c.^dnu_bwd(k))'.*bwd;
  end

  dqr(tb_reacs,:) = tb_coeffs.*qr(tb_reacs)+cM.*dqr(tb_reacs,:);
end
