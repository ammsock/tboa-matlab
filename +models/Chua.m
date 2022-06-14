classdef Chua < models.Model
  properties
    name = "Chua's system"
    pdim = 3
    vdim = 3
    gamma = 5
    a = -8/7
    b = -5/7
    beta = 100/7
  end
  methods
    function obj = Chua(gamma)
      if nargin == 1
        obj.gamma = gamma;
      end
    end

    function vf = vectorfield(obj,p)
      f = zeros(1,size(p,2));
      f(p(1,:)>1) = obj.b*p(1,(p(1,:)>1))+obj.a-obj.b;
      f(p(1,:)<=-1) = obj.b*p(1,(p(1,:)>1))-obj.a+obj.b;
      f((p(1,:)<=1)&&(p(1,:)>-1)) = obj.a*p(1,(p(1,:)<=1)&&(p(1,:)>-1));

      vf = [(p(2,:)-p(1,:)-f)/obj.gamma; ...
        p(1,:)-p(2,:)+p(3,:);
        -obj.beta*p(2,:)];
    end

    function jac = jacobian(obj,p)
      if (p(1)<1) && (p(1)>-1)
        df = [obj.b, 0, 0];
      elseif p(1)<=-1
        df = [obj.a, 0, 0];
      end

      jac = [([-1, 1, 0]-df)/obj.gamma; ...
        1, -1, 1;
        0, -obj.beta, 0];
    end

    function p0 = rand_init_val(obj,num,xrange,yrange,zrange)
      arguments
        obj
        num = 1
        xrange = [-5,5]
        yrange = [-5,5]
        zrange = [-5,5]
      end
      p0 = [xrange(1);yrange(1);zrange(1)]+[diff(xrange);diff(yrange);diff(zrange)].*rand(obj.pdim,num);
    end

    function f = naim(obj,p)
      f = ones(1,size(p,2));
      idx = p(2,:)>=
      f(p(2,:)>=-
      y = x./(x+1);
    end
  end
end
