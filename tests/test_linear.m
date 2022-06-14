close all
clear all

% addpath('..')

gamma = 5;

T = [1 1;
     0 1];
A = T*diag([-1,-gamma])*inv(T);

model = models.GeneralLinear(A);

reso = 51;
x = linspace(-14,14,reso);
y = linspace(-5,5,reso);

tspan = [-5,5];
p0 = [[5;0],[2.5;-0.28],10*(rand(2,1)-0.5)];

%% Plot vectorfield
% figure()
% model.plot_vectorfield(linspace(-5,5,10),linspace(-5,5,10));

%% First variation
% figure()
% model.plot_first_variation(tspan);

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
tfs = [0,1;-1,0;-1,1];
% figure
% model.plot_ftles(tfs,x,y);
