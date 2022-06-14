function len = speed_at_point(obj,p)
  % len = zeros(size(x,1),1);

  % disp('speed_at_point')
  vf = obj.vectorfield(p);
  if obj.adiabatic
    len = vecnorm(vf(2:end,:),2);
  else
    len = vecnorm(vf,2);
  end

  % for k=1:size(x,1)
  %   vf = obj.vectorfield(x(k,:));
  %   len(k) = norm(vf(2:end),2);
  % end
end
