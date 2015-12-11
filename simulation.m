
addpath('mesh_toolbox');
mesh = createTestSurface('torus', 40);

% set up the parameters

h = 0.1;        % step size
steps = 200;    % number of steps

x = [0 0 0]';	% translation
v = [0 0 0]';	% velocity
r = eye(3);     % rotation
w = [0 0 0]';	% angular velocity

n = size(mesh.V, 2);	% number of vertices
F = [0 0 0]';           % force
N = [0 0 0]';           % net torque
I = zeros(3);           % inertia tensor in object space
M = 1 ;                 % mass
c = sum(mesh.V, 2) / n; % mass centre

color1 = [0.9 0.6 0.4];
color2 = [0.9 0.75 0.3];

for i = 1: n
    p0 = mesh.V(:, i) - c;
    delta = [p0(2)*p0(2)+p0(3)*p0(3), -p0(1)*p0(2), -p0(1)*p0(3);
        -p0(2)*p0(1), p0(1)*p0(1)+p0(3)*p0(3), -p0(2)*p0(3);
        -p0(3)*p0(1), -p0(3)*p0(2), p0(1)*p0(1)+p0(2)*p0(2)];
    I = I + delta;
end

% main loop for animation
video = VideoWriter('motion.avi');
open(video);

for i = 1:steps
    % update the position of vertices
    p = mesh;
    p.V = r * (mesh.V - repmat(c, 1, n)) + repmat(c, 1, n) + repmat(x, 1, n);
    
    % display the object
    drawnow
    plotMesh(p, 'solid', color2);
    hold on
    plotMesh(mesh, 'solid', color1);
    hold off
    frame = getframe;
    writeVideo(video,frame);
    
    % add random force and torque
    F = 5 * [2*rand-1 2*rand-1 2*rand-1]';
    N = 100 * [2*rand-1 2*rand-1 2*rand-1]';
    
    % update paramters (euler integration)
    omega = [0, -w(3), w(2); w(3), 0, -w(1); -w(2), w(1), 0];
    x = x + h * v;
    v = v + h * F / M;
    w = w + h * (r * I * r') \ N;
    r = r + h * omega * r;
    [U, S, V] = svd(r);
    r = U * V';
end

close(video);



