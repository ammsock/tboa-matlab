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

tf = (1:1:5)';
tspan = [zeros(size(tf)),tf];
ntf = size(tspan,1);

reaction_type = "isotherm";
% reaction_type = "adiabatic";

if reaction_type == "isotherm"
  T0 = 3000;
  model = models.IcePic(T0);
  p0 = model.rand_init_val();

elseif reaction_type == "adiabatic"
  h = 1.326e7;
  model = models.IcePic(0,h);
  while T0 <= 0
    p0 = model.rand_init_val();
    T0 = p0(1);
  end
end
selected_model = 'linear';
% selected_model = 'davis_skodje';
% selected_model = 'michaelis_menten';

if strcmp(selected_model,'linear')
  gamma = 5;
  T = [1 1; 0 1];
  A = T*diag([-1,-gamma])*inv(T);
  model = models.GeneralLinear(A);

  xrange = [-10,25];
  yrange = [-5,5];
  xrange_init = [1,2];
  yrange_init = [-1,1];

  epsilons = [0.2];
elseif strcmp(selected_model,'davis_skodje')
  gamma = 2;
  model = models.DavisSkodje(gamma);

  xrange = [-0.1,15];
  yrange = [-0.1,1.5];
  xrange_init = [1,2];
  yrange_init = [-1,1];

  epsilons = [0.1];
elseif strcmp(selected_model,'michaelis_menten')
  gamma = 3;
  kappa = 1;
  lambda = 1;
  model = models.MichaelisMenten(gamma,kappa,lambda);

  xrange = [-0.2,1.8];
  yrange = [-2,2];
  xrange_init = [1,2];
  yrange_init = [-1,1];

  epsilons = [0.1];
else
  throw(['Unknown model: ',selected_model])
end

%% Plot trajectories
model.plot_trajectories([0,2],[],30);

%% Plot K
reso = 200;
x = linspace(xrange(1),xrange(2),reso);
y = linspace(yrange(1),yrange(2),reso);
neps = length(epsilons);
nx = length(x);
ny = length(y);
[X,Y] = meshgrid(x,y);
Speed = zeros(nx, ny);
for i=1:nx
  Speed(i,:) = model.local_speed([X(:,i)';Y(:,i)']);
end
contour(X',Y',Speed,repelem(epsilons,2),'k-','LineWidth',1.5)

%% Solve TBOA
p0 = model.rand_init_val(1,xrange_init,yrange_init);
p0_sol = zeros(length(p0),ntf);
for j=1:neps
  for k=1:ntf
    while true
      % Solve TBOA
      try
        objfun = @(p) model.tboa_objfun(tspan(k,:),p);
        nonlcon = @(p) model.tboa_nonlcon(epsilons(j),tspan(k,:),p);
        [p0_sol(:,(j-1)*ntf+k),f_sol] = model.tboa(objfun,nonlcon,p0);
      catch e
        if strcmp(e.identifier,'CustomError:TimeExceeded')
          fprintf(1,'fmincon: %s -> try new initial value',e.message)
          p0 = model.rand_init_val(1,xrange_init,yrange_init);
          continue
        else
          rethrow(e)
        end
      end
      break
    end

    % [~,expl] = model.tboa_obj_fun(tspan,p0_sol(:,(j-1)*ntf+k));
    % disp(expl)

    % plot(p0_sol(1,(j-1)*ntf+k),p0_sol(2,(j-1)*ntf+k))
    label = sprintf('\\epsilon=%g,t=(%g,%g)',epsilons(j),tspan(k,1),tspan(k,2));
    label = num2str(k);
    text(p0_sol(1,(j-1)*ntf+k),p0_sol(2,(j-1)*ntf+k),label,'FontSize',14)

    [ts_sol,ps_sol] = model.simulate(tspan(k,:),p0_sol(:,(j-1)*ntf+k));
    plot(ps_sol(1,:),ps_sol(2,:),'b','LineWidth',1.2)
    p0 = [p0_sol(1,(j-1)*ntf+k);p0_sol(2,(j-1)*ntf+k)];
  end
end
