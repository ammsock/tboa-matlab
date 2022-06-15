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

model = models.CenterManifold();

reso = 51;
x = linspace(-5,5,reso);
y = linspace(-5,5,reso);

tspan = [0,10];
p0 = [[5;0],[0;5],model.rand_init_val(10)];

%% Plot vectorfield
% figure()
% model.plot_vectorfield(linspace(-5,5,10),linspace(-5,5,10));

%% First variation
figure()
model.plot_first_variation(tspan);

%% Plot trajectories
figure
model.plot_trajectories(tspan,p0);

%% Plot speed
figure
model.plot_speed(tspan,p0);

%% Plot FTLE over time
figure
model.plot_ftle_over_time(tspan,p0);

%% Plot FTLEs
tfs = [0,1]; %;-1,0;-1,1];
% figure
% model.plot_ftles(tfs,x,y);
