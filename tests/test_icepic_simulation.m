close all
clear all

% addpath('..');

% ONB of the 3D subspace of mass conservation
onb = [ 0.654653670707977                   0                   0;
       -0.436435780471985   0.816496580927726                   0;
        0.436435780471985   0.408248290463863   0.408248290463863;
                        0                   0  -0.816496580927726;
       -0.436435780471985  -0.408248290463863   0.408248290463863;
                        0                   0                   0];

reaction_type = 'isotherm';
% reaction_type = 'adiabatic';

if strcmp(reaction_type,'isotherm')
  T0 = 3000;
  conserved = T0;
  model = models.IcePic(T0);
  p0 = model.rand_init_val();
  % p0 = [conserved;c0];

elseif strcmp(reaction_type,'adiabatic')
  h = 1.326e7;
  conserved = h;
  model = models.IcePic(0,h);
  while T0 <= 0
    p0 = model.rand_init_val();
    T0 = p0(1);
    % T0 = model.get_temp(c0,conserved)
    % p0 = [T0;c0];
  end
end

tf = 1e-5;

[ts,ps] = model.simulate([0,tf],p0);
Ts = ps(1,:);
cs = ps(2:end,:);

figure()
% Plot species
for j=1:(size(cs,1)-1)
    g = semilogx(ts,cs(j,:),'.-');%,'MarkerSize',5);
    hold on
end
% set(gca,'ColorOrderIndex',1);
% for j=1:(length(c0)-1)
%     g = semilogx(t2,cs_sol2(:,j),'o-','MarkerSize',5);
%     set(g, 'MarkerFaceColor', get(g,'Color'));
%     hold on
% end
% set(gca,'ColorOrderIndex',1);
% for j=1:(length(c0)-1)
%     g = semilogx(t3,cs_sol3(:,j),'o-','MarkerSize',4);
%     hold on
% end
yline(0.0);
title(strcat('Concentrations over time (',reaction_type,' reaction), T_0= ',num2str(T0),' K'))
% species_sol = strcat(model.species,'_{sol}');
% species_sol2 = strcat(species,'_{sol}^2');
% species_sol3 = strcat(species,'_{sol}^3');
legend(model.species{1:(end-1)}) %,species_sol2{1:(end-1)},species_sol3{1:(end-1)})
xlabel('Time')
ylabel('Concentration c_s')


if reaction_type ~= "isotherm"
    % Plot temperature
    figure
    hold off
    semilogx(ts,Ts)
    legend('T')
end

% Plot speed
figure
vf_sol = zeros(6,length(ts));
% vf_sol2 = zeros(length(t2),6);
% vf_sol3 = zeros(length(t3),6);
speed_sol = zeros(1,length(ts));
% speed_sol2 = zeros(length(t2),1);
% speed_sol3 = zeros(length(t3),1);
% for j=1:length(ts)
    % qr_sol(:,j) = model.progress_rate(Ts(j),cs(:,j));
    % normqr_sol(j) = norm(qr_sol(:,j),2);
    % vf_sol(:,j) = model.vectorfield([Ts(j);cs(:,j)]);
    % speed_sol(:,j) = abs(progress_rate(temp_sol(j),cs_sol(:,j)))';
% end
normqr_sol = vecnorm(model.progress_rate(Ts,cs),2);
speed_sol = model.speed([Ts;cs]);

% K = equilibrium_constant(T0);
loglog(ts,speed_sol)
yline(1.0);
title('Speed')

figure
loglog(ts,normqr_sol)
title('Norm Progress Rate')

% [cs_sol2(100:end,1),cs_sol2(100:end,2),cs_sol2(100:end,1),cs_sol2(100:end,2).^2/K(4),cs_sol2(100:end,1)-cs_sol2(100:end,2).^2/K(4)]
