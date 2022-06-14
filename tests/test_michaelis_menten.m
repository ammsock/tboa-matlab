close all
clear all

% addpath('..')

gamma = 1;
kappa = 1;
lambda = 1;

model = models.MichaelisMenten(gamma,kappa,lambda);

reso = 51;
x = linspace(0,20,reso);
y = linspace(-5,5,reso);

[X,Y] = meshgrid(x,y);

% %% Plot vectorfield
% figure
% model.plot_vectorfield(linspace(0,10,10),linspace(-5,5,10));

% %% First Variation
% tspan = [0,5];
% figure
% model.plot_first_variation(tspan);

%% Plot FTLE over time
p0 = [[5;model.sim(5)],[0;-5],10*(rand(2,1)-[0;0.5])];
tspan = [0,5];

figure
model.plot_speed(tspan,p0);
figure
model.plot_ftle_over_time(tspan,p0);
figure
model.plot_trajectories(tspan,p0);

%% Plot FTLEs
tfs = [1,5];
figure
model.plot_ftles(tfs,x,y);

%%% Local functions

%% Adjoint FTLEs
% Mu = zeros(size(X));
% Mu2 = zeros(size(X));
% Mu3 = zeros(size(X));

% for i=1:reso
% 	for j=1:reso
% 		Mu(i,j) = model.ftle_adj([X(i,j),Y(i,j)],[0,-1;1,0]*model.vectorfield([X(i,j),Y(i,j)]),1);
% 		Mu2(i,j) = model.ftle_adj([X(i,j),Y(i,j)],[0,-1;1,0]*model.vectorfield([X(i,j),Y(i,j)]),5);
% 		Mu3(i,j) = model.ftle_adj([X(i,j),Y(i,j)],[0,-1;1,0]*model.vectorfield([X(i,j),Y(i,j)]),25);
% 	end
% end
% figure()
% title('adjoint FTLE')
% subplot(1,3,1)
% surf(X,Y,Mu)
% view(2)

% subplot(1,3,2)
% surf(X,Y,Mu2)
% view(2)

% subplot(1,3,3)
% surf(X,Y,Mu3)
% view(2)
