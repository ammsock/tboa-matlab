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

% addpath('..')

gamma = 5;
model = models.DavisSkodje(gamma);

reso = 51;
x = linspace(0,10,reso);
y = linspace(-5,5,reso);

[X,Y] = meshgrid(x,y);

p0 = [[5;5/6],10*(rand(2,2)-[0;0.5])];
tspan = [-1,1];

%% Plot vectorfield
% figure
% model.plot_vectorfield(linspace(x(1),x(end),10),linspace(y(1),y(end),10));

%% First Variation
tspan = linspace(0,5,10);
figure
model.plot_first_variation(tspan,p0);

%% Plot trajectories
% figure
% model.plot_trajectories(tspan,p0);

%% Plot speed
% figure
% model.plot_speed(tspan,p0);

%% Plot FTLE over time
% figure
% model.plot_ftle_over_time(tspan,p0);

%% Plot FTLEs
tfs = [-1,1];
% figure
% model.plot_ftles(tfs,x,y);
