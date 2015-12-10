function x2 = odestep(x1, f, h, solver, fparams)
% given current state x1 and time-step h, with dynamics f, compute next
% step
%
% Note: to call f, run "feval(f,x,fparams)"


if strcmp(solver, 'euler')
    x2 = x1 + h * feval(f, x1, fparams);    
else
    if strcmp(solver, 'imp_euler')
        x2 = x1 + h / 2 * ( feval(f, x1, fparams) + feval(f, h * feval(f, x1, fparams), fparams));
    else
        if strcmp(solver, 'rk4')
            k1 = h * feval(f, x1, fparams);
            k2 = h * feval(f, x1 + k1/2, fparams);
            k3 = h * feval(f, x1 + k2/2, fparams);
            k4 = h * feval(f, x1 + k3, fparams);
            x2 = x1 + (k1 + 2*k2 + 2*k3 + k4) / 6;
        else
            error('Unknown solver specified')
        end
    end
end

