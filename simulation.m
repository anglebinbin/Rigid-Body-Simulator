% set up the parameters
h       = 0.001;        % time step
x0      = [0; 0; 0; 0]; % initial state
nsteps  = round(20/h);  % number of steps
g       = 9.8;          % gravitational constant
m       = 1;            % mass of every particle
params  = [rho/(m*len*len), g/len]; % squre of omega

addpath('mesh_toolbox');
mesh = createTestSurface('torus', 30);
%plotMesh(mesh, 'solid');
%mesh = rbfReconstruction('bunny-500.pts', 0.001);

x = [0; 0; 0];  % translation of particles
v = [1; 1; 0];  % velocity
r = eye(3);   % rotation
w = [0; 0; 0];  % angular velocity
omega = zeros(3); 

n = size(mesh.V, 2);
F = [0; 0; -g];
M = n * m;
N = [0; 0; 0];

c = sum(mesh.V, 2) / n;

I = zeros(3); % inertia tensor in object space
for i = 1: n
    p0 = mesh.V(:, i) - c;
    delta = [p0(2)*p0(2)+p0(3)*p0(3), -p0(1)*p0(2), -p0(1)*p0(3);
             -p0(2)*p0(1), p0(1)*p0(1)+p0(3)*p0(3), -p0(2)*p0(3);
             -p0(3)*p0(1), -p0(3)*p0(2), p0(1)*p0(1)+p0(2)*p0(2)];
    I = I + delta;
end

p = mesh;
handle = plotMesh(p);
for i = 1:200
    % update the position of vertices
    p = mesh;
    p.V = r * mesh.V + repmat(x, 1, n);
    
    % display the object
    drawnow
    plotMesh(p, handle);
    
    % update the parameters
    omega = [0, -w(3), w(2); w(3), 0, -w(1); -w(2), w(1), 0];
    x = x + v;
    v = v + F / M;
    w = w + (r * I * r') \ N;
    r = r + omega * r;
end



