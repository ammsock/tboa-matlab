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

close all
clear all

reso = 101;
tspan = [0,1];

% selected_model = "linear";
% selected_model = "davis_skodje";
selected_model = "michaelis_menten";

if selected_model == "linear"
  gamma = 5;
  T = [1 1; 0 1];
  A = T*diag([-1,-gamma])*inv(T);
  model = models.GeneralLinear(A);

  x = linspace(-5,5,reso);
  y = linspace(-5,5,reso);

  p0 = [[5;0],[2.5;-0.28],model.rand_init_val(1)];

elseif selected_model == "davis_skodje"
  gamma = 5;
  model = models.DavisSkodje(gamma);

  x = linspace(0,10,reso);
  y = linspace(-5,5,reso);

  p0 = [[5;model.sim(5)],[0;3],model.rand_init_val(1)];

elseif selected_model == "michaelis_menten"
  gamma = 1;
  kappa = 1;
  lambda = 1;
  model = models.MichaelisMenten(gamma,kappa,lambda);

  x = linspace(0,20,reso);
  y = linspace(-2,2,reso);

  p0 = [[2;model.sim(2)],model.rand_init_val(2)];

else
  throw(['Unknown model: ',selected_model])
end


%% Plot vectorfield
% figure
% model.plot_vectorfield(linspace(x(1),x(end),10),linspace(y(1),y(end),10));

%% Plot first variation
% figure
% model.plot_first_variation(tspan);

%% Plot trajectories
figure
model.plot_trajectories(tspan,p0,10);
xlim([x(1),x(end)]);
ylim([y(1),y(end)]);

%% Plot speed
figure
model.plot_speed(tspan,p0);

%% Plot FTLE over time
figure
model.plot_ftle_over_time(tspan,p0);

%% Plot FTLEs
% tfs = [0,1];
% figure
% model.plot_ftles(tfs,x,y)
