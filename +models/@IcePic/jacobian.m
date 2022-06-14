function jac = jacobian(obj,p);

  dqr = obj.diff_progress_rate(p(1),p(2:end));

  nu = [-1,-1,0,-1,0,0;
        1,1,0,2,-1,-1;
        -1,0,-1,0,-1,0;
        1,-1,2,0,1,-1;
        0,1,-1,0,0,1;
        0,0,0,0,0,0];

  jac = nu'*dqr;

end

