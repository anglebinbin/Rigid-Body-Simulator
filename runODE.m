% set up the parameters
h       = 0.1;           % time step
x0      = [pi/2, 0]';   % initial state
nsteps  = 200;          % number of steps
len     = 5;            % length of the rod
g       = 9.8;          % gravitational constant
m       = 1;            % mass of the particle
rho     = 0.0;          % friction factor
params  = [rho/(m*len*len), g/len]; % squre of omega

X = zeros(2,nsteps);
X(:,1) = x0;

T = zeros(1,nsteps);        % kinetic energy
U = zeros(1,nsteps);        % potential energy
Total = zeros(1, nsteps);	% total energy

for i = 1:nsteps-1
    fprintf('Step: %03d, time: %3.2f     \r',i, h*i);
    
    subplot(1,2,1, 'replace');
    title('pendulum')
    axis square
    drawPendulum(X(1,i));
    drawnow
    
    T(i) = m * (len * X(2, i))^2 / 2;
    U(i) = m * g * len * (1 - cos(X(1, i)));
    Total(i) = T(i) + U(i);
    
    subplot(1,2,2);
    
    plot(T(1:i));
    hold on
    plot(U(1:i));
    plot(Total(1:i));
    
    axis square;
    title('energies');
    xlabel('time step');
    ylabel('energy');
    legend('kinetic energy', 'potential energy', 'total energy', 'Location','northwest');
    
    hold off
    
    % update the state & energies
    X(:,i+1) = odestep(X(:,i),@pend,h,'imp_euler',params);
    
end