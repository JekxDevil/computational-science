function [p] = dogleg(h, g, delta)
    % newton step pB
    pB = -h\g;

    if norm(pB) <= delta
        p = pB;
        return
    end

    % cauchy point pU
    pU = - ((g' * g) / (g' * h * g)) * g;

    % step p
    if norm(pU) > delta
        p = delta * pU / norm(pU);
        return
    end

    p = pU + chooseTau(pB, pU, delta) * (pB - pU);