classdef LinearModel
  properties
    gamma = 5
  end
  methods
    function obj = LinearModel(gamma)
      if nargin == 1
        obj.gamma = gamma;
      end
    end

    function v = vf(obj,x,y)
      v = [(-1-obj.gamma/2)*x + obj.gamma/2*y;
        obj.gamma/2*x + (-1-obj.gamma/2)*y];
    end

    function y = sim(obj,x)
      y = x;
    end
  end
end
