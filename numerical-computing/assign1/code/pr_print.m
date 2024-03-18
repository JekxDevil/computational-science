function [] = pr_print(U, x, r, c)
    % Print URLs in page rank order.
    [~,q] = sort(-x);
    fprintf('\t # \t   i  page-rank  in  out  url');
    k = 1;
    maxN = length(U);
    while  (k <= maxN) && (x(q(k)) >= .005)
        fprintf("\n\t %d", k);
        j = q(k);
        temp1  = r(j);
        temp2  = c(j);
        fprintf('\t %3.0f %8.4f %4.0f %4.0f  %s', ...
          j, x(j), full(temp1), full(temp2), U{j});
        k = k+1;
    end
    fprintf("\n");
end
