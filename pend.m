function xdot = pend(x, params)
% compute the dynamics of the pendulum given the current state
velocity = x(2);
acceleration = - params(1) * velocity - params(2) * sin(x(1));
xdot = [velocity; acceleration];
