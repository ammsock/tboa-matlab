function [ts,ps,vs,ws] = simulate(obj,tspan,p0,v0s,w0s)
  arguments
    obj
    tspan
    p0
    v0s=1:0
    w0s=1:0
  end

  paren = @(x,varargin) x(varargin{:});
  % curly = @(x,varargin) x{varargin{:}};

  [mp,np] = size(p0);
  [mv,nv] = size(v0s);
  [mw,nw] = size(w0s);
  n = np+nv+nw;

  % persistent it
  % if isempty(it)
  %   it = 0;
  % end
  % it = it+1;
  % fprintf('simulate() count: %d (np=%d, nv=%d, nw=%d)\n',it,np,nv,nw)

  z0 = [p0(:);v0s(:);w0s(:)];

  prange = 1:(np*mp);
  vrange = (np*mp+1):(np*mp+nv*mv);
  wrange = (np*mp+nv*mv+1):(np*mp+nv*mv+nw*mw);

  z2p = @(z) reshape(z(prange),[mp,np]);
  dp = @(z) paren(obj.vectorfield(z2p(z)),':');

  if nv+nw==0
    dz = @(t,z) paren(dp(z),':');
  elseif np==1
    z2v = @(z) reshape(z(vrange),[mv,nv]);
    z2w = @(z) reshape(z(wrange),[mw,nw]);

    dv = @(z) paren(obj.diff_velocity(z2p(z),z2v(z)),':');
    dw = @(z) paren(obj.codiff_velocity(z2p(z),z2w(z)),':');

    dz = @(t,z) [dp(z); dv(z); dw(z)];
  else
    error('Error: simulate.m: np>1 && nv+nw>0 currently not supported')
  end

  % tic
  function v = dotz(t,z)
    % max_time = 100;
    % if toc > max_time
    %   error('CustomError:TimeExceeded',['Error: simulate.m: Time exceeded (',num2str(max_time),' s)'])
    % end
    v = dz(t,z);
  end

  ts_neg = [];
  ts_pos = [];
  zs_neg = [];
  zs_pos = [];

  if min(tspan)<0
    tspan_neg = [0,sort(tspan(tspan<0),'descend')];
    [ts_neg,zs_neg] = obj.ode(@dotz,tspan_neg,z0);
  end
  if max(tspan)>0
    tspan_pos = [0,sort(tspan(tspan>0))];
    [ts_pos,zs_pos] = obj.ode(@dotz,tspan_pos,z0);
  end
  ts = [flip(ts_neg(2:end));0;ts_pos(2:end)];
  zs = [flip(zs_neg(2:end,:));z0';zs_pos(2:end,:)];

  ts = ts';
  ps = zs(:,prange)';
  vs = zs(:,vrange)';
  ws = zs(:,wrange)';
end
