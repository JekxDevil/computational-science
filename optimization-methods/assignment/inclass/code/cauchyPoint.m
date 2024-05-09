function [p] = cauchyPoint(h, g, delta)
    psk = - delta * g / norm(g);
    ghg = g' * h * g;
    if ghg <= 0
        tau = 1;
    else
        tau = min(norm(g).^3 / (delta * ghg), 1);
    end

    p = tau * psk;
end