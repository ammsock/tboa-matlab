classdef MichaelisMenten < Model
  properties
    name = 'Michaelis-Menten model'
    pdim = 2
    vdim = 2
    epsilon = 1
    kappa = 1
    lambda = 0.5
  end
  methods
    function obj = MichaelisMenten(epsilon,kappa,lambda)
      if nargin == 3
        obj.epsilon = epsilon;
        obj.kappa = kappa;
        obj.lambda = lambda;
      end
    end

    function v = vectorfield(obj,p)
      v = [obj.epsilon*(-p(1,:)+(p(1,:)+obj.kappa-obj.lambda).*p(2,:));
        p(1,:)-(p(1,:)+obj.kappa).*p(2,:)];
    end

    function jac = jacobian(obj,p)
      jac = [obj.epsilon*(p(2,:)-1), obj.epsilon*(p(1,:)+obj.kappa-obj.lambda);
        1-p(2,:), -(p(1,:)+obj.kappa)];
    end

    function p0 = rand_init_val(obj,num,xrange,yrange)
      arguments
        obj
        num = 1
        xrange = [0,10]
        yrange = [-5,5]
      end
      p0 = [xrange(1);yrange(1)]+[diff(xrange);diff(yrange)].*rand(obj.pdim,num);
    end

    function y = sim(obj,x,n)
      if nargin == 3 && n > 3
        error('Method michaelis-menten.sim only allows terms up to order 2.')
        exit(1)
      end

      y = x./(x+obj.kappa);
      % if nargin == 2 || n == 2
            y = y + x*obj.kappa*obj.lambda./(x+obj.kappa).^4;
        % end
    end

    % Override
    function varargout = ode(obj,varargin)
      options = odeset('BDF','on','RelTol',1e-5,'AbsTol',1e-10);
      [varargout{1:nargout}] = ode15s(varargin{:}, options);
    end

    % Override
    function [c,ceq] = tboa_nonlcon(obj,epsilon,tspan,p);
      [c,ceq] = tboa_nonlcon@models.Model(obj,epsilon,tspan,p);
      c = -p(1);
      % ceq = p(1)-epsilon;
    end
  end
end
