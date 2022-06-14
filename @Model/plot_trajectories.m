function plot_trajectories(obj,tspan,p0,num_rand)
  arguments
    obj
    tspan
    p0
    num_rand = 0
  end

  p0s_rand = obj.rand_init_val(num_rand);

  for k=1:num_rand
    [ts,ps] = obj.simulate(tspan,p0s_rand(:,k));

    plot(ps(1,ts==0),ps(2,ts==0),'o','Color',[0.8 0.8 0.8])
    hold on
    plot(ps(1,:),ps(2,:),'Color',[0.8 0.8 0.8],'LineWidth',0.1)
  end

  set(gca,'ColorOrderIndex',1)
  for k=1:size(p0,2)
    [ts,ps] = obj.simulate(tspan,p0(:,k));

    coi = get(gca,'ColorOrderIndex');
    plot(ps(1,ts==0),ps(2,ts==0),'o')
    hold on
    set(gca,'ColorOrderIndex',coi);
    plot(ps(1,:),ps(2,:),'LineWidth',1.5)
  end

  title(sprintf('%s: trajectories',obj.name))
  hold off
end
