classdef CenterManifold < Model
  properties
    name = "center manifold system"
    pdim = 2
    vdim = 2
  end
  methods
    function vf = vectorfield(obj,p)
      vf = [-p(1,:).^3; -p(2,:)];
    end

    function jac = jacobian(obj,p)
      jac = [3*p(1)^2, 0; 0, -1];
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
