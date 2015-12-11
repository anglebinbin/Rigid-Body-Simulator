function mesh = createTestSurface(type, N)
% mesh = createTestSurface(type, N, baseMesh)
% type='sphere', 'torus', 'helicoid', 'saddle', 'cylinder'
% N is grid resolution in the parameter shape (grid will be NxN)
% returns a polygon mesh of the specified analytic surface

if nargin ~= 2
    error('you have to provide the type of surface and [u,v] grid resolution as input to the function');
end

[u v] = meshgrid(0:1/N:1, 0:1/N:1);
X = u;
Y = v;
Z = zeros( size(u) );
[f,v] = surf2patch(X, Y, Z);
close;
plane.V = v';
plane.V(4,:) = 1;
plane.F = [f(:,1:3)', f(:,[3:4,1])'];

if strcmp( type, 'torus' )
    b = 1;
    a = 4;

    mesh.V(1, :) = (a + b * cos( plane.V(2, :) * (2*pi) )) .* cos( plane.V(1, :) * (2 * pi) );
    mesh.V(2, :) = (a + b * cos( plane.V(2, :) * (2*pi) )) .* sin( plane.V(1, :) * (2 * pi) );
    mesh.V(3, :) = b * sin( plane.V(2, :) * (2 * pi) );
    mesh.F = plane.F;
    mesh = removeRepeatedVerts(mesh);
elseif strcmp( type, 'cylinder' )
    mesh.V(1, :) = cos( plane.V(1, :) * (2 * pi) );
    mesh.V(2, :) = sin( plane.V(1, :) * (2 * pi) );
    mesh.V(3, :) = (1/4) * ( plane.V(2, :) * (2 * pi) );
    mesh.F = plane.F;
    mesh = removeRepeatedVerts(mesh);
elseif strcmp( type, 'saddle' )
    mesh.V(1, :) = 2 * plane.V(1, :) - 1;
    mesh.V(2, :) = 2 * plane.V(2, :) - 1;
    mesh.V(3, :) = mesh.V(1, :).^3 - 3 * mesh.V(1, :).*mesh.V(2, :).^2;
    mesh.F = plane.F;
elseif strcmp( type, 'helicoid' )
    mesh.V(1, :) = plane.V(1, :) * (2 * pi) .* cos( plane.V(2, :) * (2 * pi) );
    mesh.V(2, :) = plane.V(1, :) * (2 * pi) .* sin( plane.V(2, :) * (2 * pi) );
    mesh.V(3, :) = plane.V(2, :) * (2 * pi);
    mesh.F = plane.F;    
end

