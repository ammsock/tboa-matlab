function p0 = rand_init_val(obj,num,xrange,yrange,zrange)
  arguments
    obj
    num = 1
    xrange = [-1,1]
    yrange = [-1,1]
    zrange = [-1,1]
  end

  ranges=[xrange;yrange;zrange];
  c0s = [];

  for k=1:num
    c0=-1;
    while any(c0 < 0)
      c0 = (null(obj.tboa_Aeq(:,2:end))*(ranges(:,1)+diff(ranges,[],2).*rand(3,1))+obj.tboa_Aeq(:,2:end)\obj.tboa_beq);
    end
    c0s = [c0s,c0];
  end

  if obj.isotherm
    p0 = [repmat(obj.T,1,size(c0s,2));c0s];
  elseif obj.adiabatic
    p0 = [obj.get_temp(c0s,obj.h);c0s];
  end
end
