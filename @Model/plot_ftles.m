%  Copyright (C) 2022 Jörn Dietrich
%  ----------------------------------------------------------------------------
% This file is part of AMMSoCK.
%
% AMMSoCK is free software: you can redistribute it and/or modify it under the
% terms of the GNU General Public License as published by the Free Software
% Foundation, either version 3 of the License, or (at your option) any later
% version. AMMSoCK is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
% FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
% details. You should have received a copy of the GNU General Public License
% along with AMMSoCK. If not, see <https://www.gnu.org/licenses/>.

function plot_ftles(obj,tspan,x,y)
  %% Handle optional arguments
  if nargin == 1
    tspan = [0 1];
  elseif nargin < 4
    reso = 101;
    x = linspace(-5,5,reso);
    y = linspace(-5,5,reso);
  end

  %% Generate grid
  [X,Y] = meshgrid(x,y);
  ntf = size(tspan,1);
  nx  = length(x);
  ny  = length(y);

  %% Instantiate variables
  Speed = zeros(nx, ny);
  Exp   = zeros(ntf, nx, ny);
  C     = zeros(ntf, nx, ny);
  DC    = zeros(ntf, nx, ny);
  UpperLipC = zeros(ntf, nx, ny);
  LowerLipC = zeros(ntf, nx, ny);
  ObjFun = zeros(ntf, nx, ny);

  nplots = 3;
  tcl = tiledlayout(ntf,nplots);

  wb = waitbar(0);

  for i=1:nx
    Speed(i,:) = obj.local_speed([X(:,i)';Y(:,i)']);
  end

  for k=1:ntf
    for i=1:nx
      p0s = [X(:,i)';Y(:,i)'];
      v0s = obj.vectorfield(p0s);
      for j=1:ny
        waitbar(((k-1)*nx*ny+(i-1)*ny+j)/(ntf*nx*ny),wb)
        w = null(v0s(:,j)');

        [ts,ps,vs,ws]  = obj.simulate(tspan(k,:),p0s(:,j),v0s(:,j),w);
        [lambda,mu,nu] = obj.ftle(ts,vs,ws);

        Exp(k,i,j)  = nu.exp;
        C(k,i,j)    = nu.c;
        DC(k,i,j)   = nu.dc;
        UpperLipC(k,i,j) = max(log(nu.cs(ts~=0))-abs(nu.exp)*ts(ts~=0));
        LowerLipC(k,i,j) = min(log(nu.cs(ts~=0))+abs(nu.exp)*ts(ts~=0));
        % ObjFun(k,i,j) = max(abs(log(nu.cs/nu.c)./ts)+nu.exp);
        ObjFun(k,i,j) = max(abs(log(nu.cs/nu.cs(end))./(ts(end)-ts))+nu.exp);
      end
    end

    %% PLOT
    plotid = (k-1)*nplots+1;
    %% Exp
    nexttile(tcl,plotid);
    plot_heatmap(obj,X',Y',squeeze(Exp(k,:,:)),Speed);
    title(sprintf('%s: \\lambda, T_%d',obj.name,k))
    plotid = plotid+1;

    %% C
    nexttile(tcl,plotid);
    plot_heatmap(obj,X',Y',squeeze(C(k,:,:)),Speed);
    title(sprintf('%s: log C(p), T_%d',obj.name,k))
    plotid = plotid+1;

    % %% lower Lip(C)
    % nexttile(tcl,plotid);
    % plot_heatmap(obj,X',Y',squeeze(LowerLipC(k,:,:)),Speed);
    % title(sprintf('%s: lower Lip(C), T_%d',obj.name,k))
    % plotid = plotid+1;

    % %% upper Lip(C)
    % nexttile(tcl,plotid);
    % plot_heatmap(obj,X',Y',squeeze(UpperLipC(k,:,:)),Speed);
    % title(sprintf('%s: upper Lip(C), T_%d',obj.name,k))
    % plotid = plotid+1;

    % %% DC
    % nexttile(tcl,plotid);
    % plot_heatmap(obj,X',Y',log(squeeze(DC(k,:,:))),Speed);
    % title(sprintf('%s: dC(p), T_%d',obj.name,k))
    % plotid = plotid+1;

    %% ObjFun
    nexttile(tcl,plotid);
    plot_heatmap(obj,X',Y',asinh(squeeze(ObjFun(k,:,:))),Speed);
    title(sprintf('%s: ObjFun(p), T_%d',obj.name,k))
    plotid = plotid+1;
  end
  close(wb)
end

function plot_heatmap(obj,X,Y,F,Speed)
    h = pcolor(X,Y,F);
    set(h,'EdgeColor','none')
    colorbar()
    % Fix color range (-> no subsequent changes through contour)
    c = caxis;
    caxis([c(1),c(2)]);
    hold on
    contour(X,Y,Speed,10,'k-')
    x = X(:,1);
    if ismethod(obj,'sim')
      plot(x,obj.sim(x),'r--')
    end
end
