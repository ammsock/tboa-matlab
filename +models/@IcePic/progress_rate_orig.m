function qr = progress_rate_orig(obj,temp,cs)

  fwd = obj.forward_rate(temp);
  bwd = obj.backward_rate(temp);

  cM = 2.5*cs(1)+cs(2)+cs(3)+cs(4)+12*cs(5)+cs(6);

  qr = [fwd(1)*cs(3)*cs(1)-bwd(1)*cs(2)*cs(4);
    fwd(2)*cs(1)*cs(4)-bwd(2)*cs(5)*cs(2);
    fwd(3)*cs(3)*cs(5)-bwd(3)*cs(4)^2;
    cM*fwd(4)*cs(1)-bwd(4)*cs(2)^2;
    cM*fwd(5)*cs(3)*cs(2)-bwd(5)*cs(4);
    cM*fwd(6)*cs(2)*cs(4)-bwd(6)*cs(5)];
end
