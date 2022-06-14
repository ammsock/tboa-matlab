function plot_ftle_over_time(obj,tspan,p0,v0,sel)
  arguments
    obj
    tspan = [0,5]
    p0 = 10*(rand(2,1)-[0;0.5])
    v0 = obj.velocity(p0)
    sel = [false false true]
  end

  % sel_plots = [true true true false];
  plot_names = {'Expo','C','dC','objfun'};
  % plot_funs = {@(o) o.exps,@(o) o.cs,@(o) o.dcs,@(o) log(exp(o.cs)+o.exp*ts)};
  % plot_xvals = {ts(ts~=0),ts,ts(ts~=0),ts};

  % struct('name','Expo',
  %        'xvals',ts(ts~=0),
  %        'yvals',@(o) o.exps)


  legend_names = {'\lambda','\mu','\nu'};
  markers = {'-','--','.-'}; % for lambda, mu, nu

  % lambda_plot = CustomPlot

  nplots = 4;
  tcl = tiledlayout(1,nplots);

  for k=1:size(p0,2)
    w0 = null(v0(:,k)');
    [ts,ps,vs,ws] = obj.simulate(tspan,p0(:,k),v0(:,k),w0);
    [lambda,mu,nu] = obj.ftle(ts,vs,ws);
    ftles = [lambda,mu,nu];

    l = 1;
    %% Plot lambdas
    ax = nexttile(tcl,l);
    multiplots(ax,ts(ts~=0),ftles(sel),@(o) o.exps,markers(sel))
    l = l+1;

    %% Plot cs
    ax = nexttile(tcl,l);
    multiplots(ax,ts,ftles(sel),@(o) o.cs,markers(sel))
    l = l+1;

    %% Plot dcs
    ax = nexttile(tcl,l);
    multiplots(ax,ts(ts~=0),ftles(sel),@(o) o.dcs,markers(sel))
    l = l+1;

    %% Plot objfun
    ax = nexttile(tcl,l);
    multiplots(ax,ts,ftles(sel),@(o) abs(log(o.cs/o.cs(end))./(ts(end)-ts))+o.exp,markers(sel))
    l = l+1;
  end

  for k=1:nplots
    ax = nexttile(tcl,k);
    xline(0,'--')
    legend(legend_names{sel})
    title(sprintf('%s: %s(t)',obj.name,plot_names{k}))
    % adjust_lims(ax,[-10,15]);
  end
end

function multiplots(axis,xvals,objs,get_prop,markers)
  coi = get(axis,'ColorOrderIndex');
  for k=1:length(objs)
    set(axis,'ColorOrderIndex',coi);
    plot(axis,xvals,get_prop(objs(k)),markers{k})
    hold on
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
