function fwd = forward_rate_prec(obj,temp)

  % disp(['size(fwd) = ',num2str(size(fwd))])
  % if size(temp,1)>1
  %   fprintf('size(temp) = [%d %d], ', size(temp))
  %   % fwd1 = 5.0800000000e+04*temp.^(2.700000).*exp(-3.1652086405e+03/temp);
  %   fwd1 = exp((-3.1652086405e+03)./temp);
  %   fprintf('size(fwd(1)) = [%d %d], ', size(fwd1))
  % end
  fwd = [5.0800000000e+04*temp.^(2.700000).*exp( (-3.1652086405e+03)./temp); ...
         2.1600000000e+08*temp.^(1.500000).*exp( (-1.7260291522e+03)./temp); ...
         2.9700000000e+06*temp.^(2.000000).*exp( (-6.7431921434e+03)./temp); ...
         4.5800000000e+19*temp.^(-1.400000).*exp((-5.2526082332e+04)./temp); ...
         4.7100000000e+18*temp.^(-1.000000).*exp((-0.0000000000e+00)./temp); ...
         3.8000000000e+22*temp.^(-2.000000).*exp((-0.0000000000e+00)./temp)];
  % disp(['size(fwd) = ',num2str(size(fwd))])
  % if size(temp,1)>1
  %   fprintf('size(fwd) =\t[%d %d],\n', size(fwd))
  % end
end
