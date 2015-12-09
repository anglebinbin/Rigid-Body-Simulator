% set up the parameters
h = .1;
x0 = [pi/2, 0]';
nsteps = 200;
len = 5;
g = 9.8;
m = 1;
rho = 0;
params = [rho/(m*len*len),g/len];

X = zeros(2,nsteps);
X(:,1) = x0;

T = zeros(1,nsteps);
U = zeros(1,nsteps);

for i=1:nsteps-1
  fprintf('Step: %03d, time: %3.2f     \r',i, h*i);
  
  subplot(1,2,1, 'replace');
  title('pendulum')
  drawnow
  
  subplot(1,2,2);
  title('energies')
  % TODO: plot the energy up to now
  % label the axes and put a legend
  
  
  % update the state & energies
  X(:,i+1) = odestep(X(:,i),@pend,h,'rk4',params);

end