%% Setup
% This section is just me setting up important variables in my lab.
% James Artuso
% 10/25/2020

x = sym('x');
y = sym('y');
z = sym('z');
A = -8.4;
B = -3.2;
C = 1.7;

digits(7);
color = zeros(31, 31, 3);
color(:,:,1) = 1;

%For every question involving f, I am using Dewan Chowdhurys data since
%my level set is 2 intersecting lines.
f(x,y) = 2*x + 3*y + x*y - 3*x^2 + 2*y^2 - 1;
g = 3*x.*y-5*y-4*x+2*x.*z+2*y.*z+(2*x.^2)+(3*y.^2)-(3*z.^2)+6;


%% A sketch of the curve(s) satisfying f(x,y) = 0
% This section is relativly simple as fimplicit graphs the level curve. I
% did not input f==0 since that is the default value it is solving for.

figure
fimplicit(f,[-15 15]);

%% Compute the points of the form (A, y) that are on the curve.
% This is done by explicitly solving f(x,y). I did this by using matlabs
% built in function "solve". This creates a parametric representation of
% the curve in terms of x. It should create 2 equations since the level
% set of f(x,y) has two branches, and the implicit function theorem tells
% us that the parametric representation must be one to one.

fSolved = solve(f,y);

PointsOnCurve = double(subs(fSolved,x,A));

%The points are...
sprintf('(%f, %.6f)',A,PointsOnCurve(1))
sprintf('(%f, %.6f)',A,PointsOnCurve(2))

%% Find the equaiton of the tangent line to the curve f(x,y) = 0 at each of the form (A,y).
% This is done by using the implicit definition of the level set. This
% creates an equation of the form 0= m1(x-A)+m2(y-c), where m1 and m2 are
% the x and y partial derivatives evalueated at (A, c) respectivly. 

fx(x,y) = diff(f,x);fy(x,y) = diff(f,y);

m1 = [fx(A,PointsOnCurve(1)); fx(A,PointsOnCurve(2))];
m2 = [fy(A,PointsOnCurve(1)); fy(A,PointsOnCurve(2))];


lines = vpa(m1.*(x-A)+ m2.*(y-PointsOnCurve));

%The tangent lines are...
sprintf('0 = %s',lines(1))
sprintf('0 = %s',lines(2))

%% Draw a plot of this curve f(x,y)=0 along with the tangent lines. 
figure
hold on
fimplicit(f, [-15,15]);
fimplicit(lines(1));
fimplicit(lines(2))
plot(A, subs(fSolved(1),x,A),'o');
plot(A, subs(fSolved(2),x,A),'o');
hold off
%% Comparing to calculus 1
% The matlab function solve gives y in terms of x. This means that my
% fSolved variable contains the form y = h(x). With this, I can use
% calculus 1 to find the derivative of the greater function. With the
% derivative of the greater funciton, I can use (y-c) = m(x-A) to find the
% tangent line.

greaterValue(x) = fSolved;
if greaterValue(1) > greaterValue(2)
    greaterValue(x) = fSolved(1);
else
    greaterValue(x) = fSolved(2);
end

derive(x) = diff(greaterValue,x);
m = derive(A);

calc1Tangent = vpa(m*x-m*A+greaterValue(A));

sprintf('y = %s',calc1Tangent)

figure
hold on
fimplicit(f, [-15,15]);
line([-15:15], subs(calc1Tangent, x, [-15:15]));
plot(A, subs(calc1Tangent,x,A),'o');
hold off

%when comparing the two results from the different methods, graphically
%they look identical. Algebraically, you can solve the equation from number
%three for y. This gives you y = -1.494626 - 0.408451. This is almost
%identical to the calculus 1 tangent line equation. This shows that they
%are the same line, just in different forms. Number three comes from
%solving f(x,y) = 0 implicitly, and this comes from solving it explicitly.

%% Draw a sketch of the surface g(x,y,z) = 0
% This is done by using the fimplicit3 function. I did not use g==0 since
% this is the default equation it uses.

figure
fimplicit3(g, [-15 15 -15 15 -15 15]);
view([32.7, 12.6])

%% Compute the points of the form (B, C, z) that are on this surface
% This is done by setting g(x,y,z) = 0 and solving for z. This should give
% 2 equations in terms of x and y. This is because the level set is shaped
% like a three dimensional version of a hyperbola.

gSolved = solve(g,z);
PointsOnSurface = double(subs(subs(gSolved,x,B),y,C));

%The points are...
sprintf('(%f, %f, %.6f)',B,C,PointsOnSurface(1))
sprintf('(%f, %f, %.6f)',B,C,PointsOnSurface(2))
%% Find the equation of the tangent plane to the surface g(x,y,z) = 0 at each point of the form (B, C, y)
% Since we already solved for z when g(x,y,z) = 0, we can simply use
% techniques already learned to find the tangent plane. More specifically ,
% I will be using L = f(B,C) + fx(B,C)(x-B) + fy(B,C)(y-C)

gx = diff(gSolved,x);
gy = diff(gSolved,y);

gxBC = double(subs(subs(gx,x,B),y,C));
gyBC = double(subs(subs(gy,x,B),y,C));


planes = vpa(PointsOnSurface+gxBC*x-gxBC*B+gyBC*y-gyBC*C);

%The tangent planes are...
sprintf('z = %s', planes(1))
sprintf('z = %s',planes(2))
%% Draw a plot of this surface g(x,y,z) = 0 along with the tangent planes
% This is done by using fimplicit3 for the function, and surf for the
% tanget planes

figure %Figure with both tangent planes
hold on
fimplicit3(g, [-15 15 -15 15 -15 15]);
X = -15:15;
Y = (-15:15)';
plotLines = zeros(31,31,2);
plotLines(:,:,1) = PointsOnSurface(1)+gxBC(1)*X-gxBC(1)*B+gyBC(1)*Y-gyBC(1)*C;
plotLines(:,:,2) = PointsOnSurface(2)+gxBC(2)*X-gxBC(2)*B+gyBC(2)*Y-gyBC(2)*C;
surf(X,Y,plotLines(:,:,1),color);
surf(X,Y,plotLines(:,:,2),color);
view([35.3,-2.4]);
hold off

figure %Figure of the bottom surface with its tangent plane
hold on
surf(X,Y,double(subs(subs(gSolved(1),x,X),y,Y)));
surf(X,Y,plotLines(:,:,1),color);
view([-58.5, -0.6]);
hold off

figure %Figure of the top surface with its tangent plane
hold on
surf(X,Y,double(subs(subs(gSolved(2),x,X),y,Y)));
surf(X,Y,plotLines(:,:,2),color);
view([97.8, 18.6]);
hold off
