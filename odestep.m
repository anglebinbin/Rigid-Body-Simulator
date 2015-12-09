function x2 = odestep(x1, f, h, solver,fparams)
  % given current state x1 and time-step h, with dynamics f, compute next
  % step
  %
  % Note: to call f, run "feval(f,x,fparams)"
  
  
  if strcmp(solver, 'euler')
    x2 = 0;  % TODO: write this
  else 
    if strcmp(solver, 'imp_euler')
      x2 = 0; % TODO: write this
    else
      if strcmp(solver, 'rk4')
	x2 = 0; % TODO: write this
      else 
	error('Unknown solver specified')
      end
    end
  end
  
    