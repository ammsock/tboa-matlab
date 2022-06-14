function fwd = forward_rate_orig(obj,temp)

  fwd = [5.080000e+04*temp^2.700000*exp(-3.165209e+00/temp);
         2.160000e+08*temp^1.500000*exp(-1.726029e+00/temp);
         2.970000e+06*temp^2.000000*exp(-6.743192e+00/temp);
         4.580000e+19*temp^-1.400000*exp(-5.252608e+01/temp);
         4.710000e+18*temp^-1.000000*exp(-0.000000e+00/temp);
         3.800000e+22*temp^-2.000000*exp(-0.000000e+00/temp)];
end
