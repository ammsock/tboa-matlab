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

clear all

% addpath('..');

T0 = 1300;

% c0 = [0.203094,0.152179,0.034597,0.0765668,0.300439,3.29533];
c0 = [rand(1,5),3.29533];

tf=1.0e1;
tspan = [0,tf];

% reaction_type = 'isotherm';
reaction_type = 'adiabatic';

ice_prec = models.icepic('prec',reaction_type);
ice_preq = models.icepic('prec_eq',reaction_type);

c0 = -1;
while any(c0 < 0)
  c0 = (null(ice_preq.Aeq)*(2*rand(3,1)-1)+ice_preq.Aeq\ice_preq.beq)';
end


%% Simulate reaction
display(['Simulating ',reaction_type,' reaction'])

[ts,xs] = ice_prec.simulate(tspan,[T0,c0]);
[ts2,xs2] = ice_preq.simulate(tspan,[T0,c0]);

Ts = xs(:,1);
cs = xs(:,2:end);

Ts2 = xs2(:,1);
cs2 = xs2(:,2:end);


%% Plot species
figure
set(gca, 'XScale', 'log');
hold on
for j=1:(length(c0)-1)
  semilogx(ts, cs(:,j), '.-');%,'MarkerSize',5);
end
set(gca,'ColorOrderIndex',1);
for j=1:(length(c0)-1)
  g = semilogx(ts2, cs2(:,j), 'o-', 'MarkerSize',5);
  set(g, 'MarkerFaceColor', get(g,'Color'));
end
yline(0.0);

species_legend = strcat(ice_prec.species,'_{prec}');
species_legend2 = strcat(ice_preq.species,'_{preq}');
legend({species_legend{1:(end-1)},species_legend2{1:(end-1)}},'Location','eastoutside')

title(['Concentrations over time (',reaction_type,'), T_0=',num2str(T0),' K'])
xlabel('Time t')
ylabel('Concentration c_s')
ylim([max(min(min([cs(:,1:5);cs2(:,1:5)])),0)-0.05,min(max(max([cs(:,1:5);cs2(:,1:5)])),1)+0.05])
hold off


%% Plot temperature
if strcmp(reaction_type,'isotherm') == 0
  figure
  semilogx(ts,Ts)
  hold on
  semilogx(ts2,Ts2)

  legend({'T_{prec}','T_{preq}'},'Location','southwest')
  title(['Temperature over time (',reaction_type,'), T_0=',num2str(T0),' K'])
  xlabel('Time t')
  ylabel('Temperature T')
  hold off
end


%% Plot speed over time
vfs = zeros(length(ts),6);
vfs2 = zeros(length(ts2),6);
norm_vfs = zeros(length(ts),1);
norm_vfs2 = zeros(length(ts2),1);

for j=1:length(ts)
  buf = ice_prec.vectorfield(Ts(j),cs(j,:))';
  vfs(j,:) = buf(end-5:end);
  norm_vfs(j) = norm(vfs(j,:),2);
  % norm_vfs(j,:) = abs(progress_rate(Ts(j),cs(j,:)))';
end
for j=1:length(ts2)
  buf = ice_preq.vectorfield(Ts2(j),cs2(j,:))';
  vfs2(j,:) = buf(end-5:end);
  norm_vfs2(j) = norm(vfs2(j,:),2);
  % norm_vfs2(j,:) = abs(progress_rate(Ts2(j),cs2(j,:)))';
end

figure
loglog(ts,norm_vfs)
hold on
loglog(ts2,norm_vfs2)
yline(1.0);

legend({'speed_{prec}','speed_{preq}'},'Location','southwest')
title(['Speed over time (',reaction_type,'), T_0=',num2str(T0),' K'])
xlabel('Time t')
hold off


%% Plot progress rate over time
qrs = zeros(length(ts),6);
qrs2 = zeros(length(ts2),6);
norm_qrs = zeros(length(ts),1);
norm_qrs2 = zeros(length(ts2),1);

for j=1:length(ts)
  qrs(j,:) = ice_prec.progress_rate(Ts(j),cs(j,:))';
  norm_qrs(j) = norm(qrs(j,:),2);
end
for j=1:length(ts2)
  qrs2(j,:) = ice_preq.progress_rate(Ts2(j),cs2(j,:))';
  norm_qrs2(j) = norm(qrs2(j,:),2);
end

figure
loglog(ts,norm_qrs)
hold on
loglog(ts2,norm_qrs2)

legend({'qr_{prec}','qr_{preq}'},'Location','southwest')
title(['Progress rate over time (',reaction_type,'), T_0=',num2str(T0),' K'])
xlabel('Time t')
hold off

% [~,i] = max(max(qrs((end-10):end,:)));
% [~,i2] = max(max(qrs2((end-10):end,:)));
