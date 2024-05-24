%% Exercise 3.2
function [x, rvec, vecx] = CG(A, b, x0, max_itr, tol)
% output:
% - x solution
% - rvec vectror containing the residual foreach iteration
    rvec = zeros(1, max_itr);
    vecx = zeros(size(x0,1), max_itr);
    r = b - A*x0;
    x = x0;
    vecx(:,1) = x;
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
        rvec(i) = p_new;
        vecx(:,1+i) = x;
        
        if p_new <= tol
            disp('Iteration Converged');
            rvec = rvec(1:i);
            vecx = vecx(:,1:1+i);
            break;
        end
    end
    
    if i == max_itr
        rvec = rvec(1:i);
        vecx = vecx(:,1:1+i);
        disp('Maximum number of iterations reached without convergence');
    end

end