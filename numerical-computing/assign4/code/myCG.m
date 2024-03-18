function [x, rvec] = myCG(A, b, x0, max_itr, tol)
% conjugate gradient solver
% output:
% - x solution value
% - rvec vectror containing the residual at every iteration
    rvec = [];
    r = b - A*x0;
    x = x0;
    d = r;
    p_old = dot(r, r);
    
    for i = 1:max_itr
        s = A*d;
        alpha = p_old / dot(d, s);
        x = x + alpha*d;
        r = r - alpha*s;
        p_new = dot(r, r);
        beta = p_new / p_old;
        d = r + beta*d;
        p_old = p_new;
        rvec = [rvec, p_new];
        
        if p_new <= tol
            disp('Iteration Converged');
            break;
        end
    end
    
    if i == max_itr
        disp('Maximum number of iterations reached without convergence');
    end

end