function [qr] = progress_rate_prec_eq(obj,temp,cs)

  fwd = obj.forward_rate(temp);
  K = obj.equilibrium_constant(temp);

  cM = 2.5*cs(1)+cs(2)+cs(3)+cs(4)+12.0*cs(5)+cs(6);

  qr = [fwd(1)*(cs(3)*cs(1)-cs(2)*cs(4)/K(1));
        fwd(2)*(cs(1)*cs(4)-cs(5)*cs(2)/K(2));
        fwd(3)*(cs(3)*cs(5)-cs(4)^2/K(3));
        cM*fwd(4)*(cs(1)-cs(2)^2/K(4));
        cM*fwd(5)*(cs(3)*cs(2)-cs(4)/K(5));
        cM*fwd(6)*(cs(2)*cs(4)-cs(5)/K(6))];

end
