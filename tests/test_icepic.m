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

% reaction_type = "isotherm";
reaction_type = "adiabatic";

if reaction_type == "isotherm"
  T0 = 2000;
  model = models.IcePic(T0);
  p0_init = model.rand_init_val();

elseif reaction_type == "adiabatic"
  % h = 1.326e7;
  h = 1.326e4;
  model = models.IcePic(0,h);
  T0 = -1;
  while T0 <= 0
    p0_init = model.rand_init_val();
    T0 = p0_init(1);
    disp(T0)
  end
end

tf = 10.^(-14:0.2:-13.0)';
% tf = 10.^(-12:0.2:-11.2)';
% tf = 1e-13;
tspan = [zeros(size(tf)),tf];
ntf = size(tspan,1);


%% Simulate initial trajectory
v_init = model.velocity(p0_init);
w_init = null(v_init');

[ts_init,ps_init,vs_init,ws_init] = model.simulate(tspan(end,:),p0_init,v_init,w_init);
[lambda_init,mu_init,nu_init] = model.ftle(ts_init,vs_init,ws_init);
Ts_init = ps_init(1,:);
cs_init = ps_init(2:end,:);

epsilon = model.local_speed(ps_init(:,end));


%% Solve TBOA
p0 = p0_init;
p0_sol = zeros(model.pdim,size(tf,1));
f_sol = zeros(1,size(tf,1));
exitflags = zeros(1,size(tf,1));

for k=1:ntf
  p0 = p0_init;
  it = 1;
  while exitflags(k)<=0
    disp('==========')
    fprintf('    %d/%d --- %d\n',k,ntf,it)
    objfun = @(p) model.tboa_objfun(tspan(k,:),p);
    nonlcon = @(p) model.tboa_nonlcon(epsilon,tspan(k,:),p);
    [p0_sol(:,k),f_sol(k),exitflags(k)] = model.tboa(objfun,nonlcon,p0);
    it = it+1;
    p0 = model.rand_init_val();
  end
  % p0 = p0_sol(:,k);
end


%% Plot trajectories
figure
model.plot_projected(tspan(1,:),[],20);

for k=1:ntf
  model.plot_projected(tspan(k,:),p0_sol(:,k),0);
  hold on
  p0_sol_proj = model.project(p0_sol(:,k));
  text(p0_sol_proj(1),p0_sol_proj(2),p0_sol_proj(3),sprintf('%d',k))
end


%% Compute solution trajectory
for k=1:ntf
  v_sol = model.velocity(p0_sol(:,k));
  w_sol = null(v_sol');
  [ts_sol{k},ps_sol{k},vs_sol,ws_sol] = model.simulate(tspan(k,:),p0_sol(:,k),v_sol,w_sol);
  [lambda_sol{k},mu_sol{k},nu_sol{k}] = model.ftle(ts_sol{k},vs_sol,ws_sol);
  Ts_sol{k} = ps_sol{k}(1,:);
  cs_sol{k} = ps_sol{k}(2:end,:);
end


%% Plot species
figure
% set(gca, 'XScale', 'log');
for j=1:(size(cs_init,1)-1)
  semilogx(ts_init,cs_init(j,:),'.-');
  hold on
end

for k=1:size(tf,1)
  set(gca,'ColorOrderIndex',1);
  for j=1:(size(cs_sol{k},1)-1)
    % ts_sol_end = ts_sol{k}(end);
    semilogx(ts_sol{k},cs_sol{k}(j,:),'o-','MarkerSize',5);
    % set(g,'MarkerFaceColor',get(g,'Color'));
    hold on
  end
end

yline(0.0);

species_init = strcat(model.species,'_{init}');
species_sol  = strcat(model.species,'_{sol}');

title(sprintf('Concentrations over time (%s reaction), T_0=%dK',reaction_type,T0))
legend({species_init{1:(end-1)},species_sol{1:(end-1)}},'Location','eastoutside')
xlabel('Time t')
ylabel('Concentration c_s')
% ylim([min(min(cs_sol(:,1:(end-1))))-0.05,max(max(cs_sol(:,1:(end-1))))+0.05])


%% Plot speed
figure
speed_init = model.local_speed(ps_init);
semilogy(ts_init,speed_init)
hold on

for k=1:size(tf,1)
  speed_sol{k} = model.local_speed(ps_sol{k});
  semilogy(ts_sol{k},speed_sol{k})
end
yline(epsilon)
legend('speed_{init}','speed_{sol}',sprintf('\\epsilon=%g',epsilon),'Location','eastoutside')

return


%% Plot objective function
% objfun_init = abs(log(nu_init.cs/nu_init.cs(end))./(ts_init(end)-ts_init))+nu_init.exp;
% objfun_sol  = abs(log(nu_sol.cs/nu_sol.cs(end))./(ts_sol(end)-ts_sol))+nu_sol.exp;

% figure
% plot(ts_init,objfun_init)
% hold on
% plot(ts_sol,objfun_sol)
% legend('objfun_{init}','objfun_{sol}','Location','eastoutside')


%% Plot speed
p0_plot = [p0_sol,model.rand_init_val(2)];

figure
model.plot_speed(tspan,p0_plot);


%% Plot FTLE over time
figure
model.plot_ftle_over_time(tspan,p0_plot);


%% Plot projected phase space
figure
model.plot_projected(tspan,p0_plot,10);


%% Display, if TBOA was successful
if exitflag <= 0
  disp('No optimum was found!')
end
fprintf('epsilon=%g\n',epsilon)
