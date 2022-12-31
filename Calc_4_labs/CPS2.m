F = sym('F');
m = sym('m');
s = sym('s');
w = sym('w');
y = sym('y');
k = sym('k');
t = sym('t');


u_1 = exp((-y/(2*m))*s)*cos(((sqrt((y^2)-4*m*k))/(2*m))*s);
u_2 = exp((-y/(2*m))*s)*sin(((sqrt((y^2)-4*m*k))/(2*m))*s);
u_1p = diff(u_1,s);
u_2p = diff(u_2,s);

W = u_1*u_2p-(u_2*u_1p);
W = simplify(W);

g = (F/m)*cos(w*s);

c_1 = -(u_2*g)/W;
c_2 = (u_1*g)/W;

c_1 = int(c_1,s,0,t);
c_2 = int(c_2,s,0,t);

c_1 = simplify(c_1);
c_2 = simplify(c_2);

full = ((((u_1)*(subs(u_2,s,t)))-((u_2)*(subs(u_1,s,t))))/W)*g;

full = int(full,s,0,t);
full = simplify(full);