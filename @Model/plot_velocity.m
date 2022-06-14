function plot_velocity(obj,x,y)
  if nargin < 3
    reso = 10;
    x = linspace(-5,5,reso);
    y = linspace(-5,5,reso);
  end

  [X,Y] = meshgrid(x,y);

  U = zeros(size(X));
  V = zeros(size(Y));

  for i=1:length(x)
    for j=1:length(y)
      p = [X(i,j);Y(i,j)];
      vf = obj.velocity(p);
      U(i,j) = vf(1);
      V(i,j) = vf(2);
    end
  end

  quiver(X,Y,U,V)
  title(sprintf('%s: vectorfield',obj.name))
end
