function varargout = ode(varargin)
  options = odeset('BDF','on','RelTol',1e-7,'AbsTol',1e-20);

  [varargout{1:nargout}] = ode15s(varargin{2:end}, options);
end
