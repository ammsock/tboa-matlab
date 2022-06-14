function plot_first_variation(obj,ts,p0,v0)
  arguments
    obj
    ts = linspace(0,5,10)
    p0 = 10*(rand(2,1))
    v0 = obj.vectorfield(p0)
  end

  if length(ts)==2
    ts = linspace(ts(1),ts(2),10);
  end

  for k=1:size(p0,2)
    %% Simulate
    [ts,ps,vs] = obj.simulate(ts,p0(:,k),v0(:,k));

    %% Plot
    % plot(ps(:,1),ps(:,2),vs(:,1),vs(:,2))
    quiver(ps(1,:),ps(2,:),vs(1,:),vs(2,:))
    title(sprintf('%s: first variation',obj.name))
    hold on
  end
  hold off
end
