k = sym('k');
w = sym('w');
m = sym('m');
y = sym('y');
F = sym('F');
A = sym('A');
B = sym('B');
t = sym('t');

(k-m*(w^2))*A + (y*w*B)
(k-m*(w^2))*B - (y*w*A)
[ASol, BSol] = solve((k-m*(w^2))*A + (y*w*B)==F, (k-m*(w^2))*B - (y*w*A) == 0, [A,B])

R = sqrt(ASol^2+BSol^2)
R = simplify(R)

%R = F/((k^2 - 2*k*m*w^2 + m^2*w^4 - y^2)^(1/2))
Rp = diff(R,w);
Rp = simplify(Rp);
