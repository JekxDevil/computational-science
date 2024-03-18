
```
f : R -> R
delta y / delta x ~~ f('x)
delta y is output error
```

Polynomial interpolation is a special case of data approximation:
find a reasonable function to represent data

sin frequency can increase or decrease to include a sample of scattered point in a plane

hence, find v(x) such that v(xi) = yi for i=0,...,n

sum(| v(xi)- yi |) for ML

model fitting: approximating a given complicated function f(x) e.g. f(x) = e^x
thus, we try to find a simpler polinomial 

Lagrange interpolation: 
PIn = {a0 * 1 + a1 * x + ... + an * x^n}
simplified in span{L0(x), ..., Ln(x)}

given n+1 points x0 < x1 < ... < xn
w(x) = product(x-xj) from j=0 to n belonging to PIn+1

thus, interpolating polynomial is p(x) = sum(yi * Li(x))
simplified in p(xj) = sum(yi * DELTAij) = yj

interpolation task has a unique solution.

Newton interpolation

divided differences

example 4.8
