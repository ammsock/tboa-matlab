classdef SingularPoint < models.Model
  properties
    name = 'Model with singular point'
    pdim = 2
    vdim = 2
    gamma = 5
  end
  methods
    function obj = SingularPoint(gamma)
      if nargin == 1
        obj.gamma = gamma;
      end
    end

    function vf = vectorfield(obj,p)
      vf = [p(2,:)-p(1,:).^2; ...
            -p(2,:)./obj.gamma];
    end

    function jac = jacobian(obj,p)
      jac = [-2*p(1), 1; ...
             0, -1;
    end

    function p0 = rand_init_val(obj,num,xrange,yrange)
      arguments
        obj
        num = 1
        xrange = [-5,5]
        yrange = [-5,5]
      end
      p0 = [xrange(1);yrange(1)]+[diff(xrange);diff(yrange)].*rand(obj.pdim,num);
    end
  end
end
