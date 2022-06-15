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

function plot_speed(obj,tspan,p0,v0)
  arguments
    obj
    tspan = [0,5]
    p0 = 10*(rand(2,1)-[0;0.5])
    v0 = obj.velocity(p0);
  end

  nplots = 3;
  tcl = tiledlayout(1,nplots);

  for k=1:size(p0,2)
    % [ts,ps] = obj.simulate(tspan,p0(:,k));
    w0 = null(v0(:,k)');

    [ts,ps,vs,ws] = obj.simulate(tspan,p0(:,k),v0(:,k),w0);
    [lambda,mu,nu] = obj.ftle(ts,vs,ws);

    nexttile(tcl,1)
    coi = get(gca,'ColorOrderIndex');
    semilogy(ts,lambda.speeds,'.-');
    hold on
    set(gca,'ColorOrderIndex',coi);
    semilogy(ts,lambda.c*exp(lambda.exp*ts),'--')

    mid_idx = floor(length(ts)/2);
    set(gca,'ColorOrderIndex',coi);
    semilogy(ts(mid_idx:end),lambda.cs(mid_idx)*lambda.speeds(mid_idx)*exp(lambda.exp*(ts(mid_idx:end)-ts(mid_idx))),'--')

    nexttile(tcl,2)
    coi = get(gca,'ColorOrderIndex');
    for k=1:size(mu.speeds,1)
      set(gca,'ColorOrderIndex',coi);
      semilogy(ts,mu.speeds(k,:),'.-');
      hold on
    end
    % set(gca,'ColorOrderIndex',coi);
    % semilogy(ts,mu.c.*exp(mu.exp.*ts),'--')

    nexttile(tcl,3)
    coi = get(gca,'ColorOrderIndex');
    semilogy(ts,nu.speeds,'.-');
    hold on
    set(gca,'ColorOrderIndex',coi);
    semilogy(ts,nu.c*exp(nu.exp*ts),'--')
  end

  plot_names = {'\lambda','\mu','\nu'};
  for k=1:nplots
    ax = nexttile(tcl,k);
    xline(0)
    title(sprintf('%s: speed %s(t)',obj.name,plot_names{k}))
    adjust_lims(ax,[1e-10,1e4]);
  end
end


function adjust_lims(axis,pref_lims)
  ylims = axis.YLim;
  new_ylims = [-inf,inf];
  if ylims(1) < pref_lims(1)
    new_ylims(1) = pref_lims(1);
  end
  if ylims(2) > pref_lims(2)
    new_ylims(2) = pref_lims(2);
  end
  ylim(axis,new_ylims);
end
