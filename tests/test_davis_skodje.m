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
