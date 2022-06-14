function plot_projected(obj,tspan,p0,num_rand)
  arguments
    obj
    tspan
    p0
    num_rand = 0
  end

  p0s_rand = obj.rand_init_val(num_rand);
  for k=1:num_rand
    [ts,ps] = obj.simulate(tspan,p0s_rand(:,k));
    ps_proj = obj.project(ps);

    plot3(ps_proj(1,ts==0),ps_proj(2,ts==0),ps_proj(3,ts==0),'o','Color',[0.8,0.8,0.8])
    hold on
    plot3(ps_proj(1,:),ps_proj(2,:),ps_proj(3,:),'Color',[0.8,0.8,0.8],'LineWidth',0.1)
    % hold on
  end

  for k=1:size(p0,2)
    [ts,ps] = obj.simulate(tspan,p0(:,k));
    ps_proj = obj.project(ps);

    % coi = get(gca,'ColorOrderIndex');
    % plot3(ps_proj(1,ts==0),ps_proj(2,ts==0),ps_proj(3,ts==0),'ob')
    % hold on
    % set(gca,'ColorOrderIndex',coi);
    plot3(ps_proj(1,:),ps_proj(2,:),ps_proj(3,:),'b','LineWidth',1.5)
    hold on
  end

  xlim([-1,1])
  ylim([-1,1])
  zlim([-1,1])
end
