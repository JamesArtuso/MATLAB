%% Prelab Setup
%James Artuso
%Lab 2
%2/28/2021
t = sym('t');
y = sym('y');
a = sym('a');
warning('off');
%% Question 1

figure
hold on
dydt(t,y)=(y^2)-1;

[tSol1, ySol1] = ode23(@(t,y)(y^2)-1,[-3 3],-1);
plot(tSol1, ySol1, 'blue');

[tSol1, ySol1] = ode23(@(t,y)(y^2)-1,[-3 3],1);
plot(tSol1, ySol1, 'blue');

[tSol1, ySol1] = ode23(@(t,y)(y^2)-1,[-3 3],-1.1);
plot(tSol1, ySol1, 'blue');

[tSol1, ySol1] = ode23(@(t,y)(y^2)-1,[-3 3],0);
plot(tSol1, ySol1, 'blue');

[tSol1, ySol1] = ode23(@(t,y)(y^2)-1,[-3 3],0.99999);
plot(tSol1, ySol1, 'blue');


quiver244(dydt, -3, 3, -3, 3, 1, 'red');
hold off


%The equilibrium solutions for this ODE are y = +-1. This is because the
%slope size zero at all y = +-1. Near the equilibrium solution y = -1, the
%solution curve tends towards the line y= -1, indicating that it is a
%stable equilibrium. Near the equilibrium solution y = 1, the solution
%curve moves away from the line y = 1, indicating that it is an unstable
%equilibrium. This is expected since (y^2-1) is raised to an odd power,
%which means that on opposite sides of an equilibrium solution, the sign of
%the slope will be different.
%For an initial value y(0) between -infinity and -1, the solution y will
%approach -1.
%For an initial value y(0) between -1 and 1, the solution y will approach
%-1. 
%For an initial value y(0) between 1 and infinity, the solution will
%approach infinity.
%These trends include initial values close to the equilibrium solutions.

%% Question 2

figure
hold on

dydt(t,y)=y*((y-2)^2)*((y+4)^3);

[tSol1, ySol1] = ode23(@(t,y) y*((y-2)^2)*((y+4)^3),[-6 4],2);
plot(tSol1, ySol1, 'blue');

[tSol1, ySol1] = ode23(@(t,y) y*((y-2)^2)*((y+4)^3),[-6 4],.1);
plot(tSol1, ySol1, 'blue');

[tSol1, ySol1] = ode23(@(t,y) y*((y-2)^2)*((y+4)^3),[-6 4],0);
plot(tSol1, ySol1, 'blue');

[tSol1, ySol1] = ode23(@(t,y) y*((y-2)^2)*((y+4)^3),[-6 4],-1);
plot(tSol1, ySol1, 'blue');

[tSol1, ySol1] = ode23(@(t,y) y*((y-2)^2)*((y+4)^3),[-6 4],-4);
plot(tSol1, ySol1, 'blue');

[tSol1, ySol1] = ode23(@(t,y) y*((y-2)^2)*((y+4)^3),[-6 4],-5);
plot(tSol1, ySol1, 'blue');

quiver244(dydt, -6, 4, -6, 4, 3, 'red');
hold off

%The equilibrium solutions for this ODE are y = 0, y = 2, and y = -4. This
%is because the slope is zero at those y levels. A y = -4, the solution is
%a stable equilibrium. For y = 0, it is an unstable equilibrium. For y = 2,
%it is semistable. This makes sense for it to be semistable because it is
%squared, this means that its value is always positive. Since it is always
%positive, the slope on either side of the equilibrium line can be the same
%sign. For y = 0 and y = -4, their respective terms are raised to odd
%powers. This means that on opposite sides of the equilibrium line, the
%slope must have opposite signs. Thus they are either stable on unstable
%solutions. 
%As t gets larger, the value of y depends on the intitial value.
%For y(0) between -infinity and 0, y will approach -4
%For y(0) between 0 and 2, y will approach 2
%For y(0) between 2 and infinity, y will approach infinity.

%% Question 3
%I answered this in the solutions to 1 and 2. 
%TLDR: If the term equaling zero is raised to an odd term, it is either
%stable or unstable. If it is raised to an even term, it is semistable.

%% Question 4

%By graphing the the vector field of the given equation at certain values of a, 
%we can easily see the phase line.

dydt(t,y) = y*((y^2)-a);

%a=-4
figure
hold on
set(5,'Name', 'a=-4');
x_val=linspace(-3,3);
y_val=linspace(-3,3);
[X,Y]=meshgrid(x_val,y_val);
Z=Y.*((Y.^2)+4);
contourf(X,Y,Z,[-Inf 0]);
quiver244(subs(dydt,a,-4), -3, 3, -3, 3, 5, 'red');
hold off;
%We can see that there is an unstable equilibrium at y=0


%a=0
figure
hold on
set(7,'Name', 'a=0');
x_val=linspace(-3,3);
y_val=linspace(-3,3);
[X,Y]=meshgrid(x_val,y_val);
Z=Y.*((Y.^2));
contourf(X,Y,Z,[-Inf 0]);
quiver244(subs(dydt,a,0), -3, 3, -3, 3, 7, 'red');
hold off;
%We can see that there is an unstable equilibrium at y=0


%a=1
figure
hold on
set(9,'Name', 'a=1');
x_val=linspace(-3,3);
y_val=linspace(-3,3);
[X,Y]=meshgrid(x_val,y_val);
Z=Y.*((Y.^2)-1);
contourf(X,Y,Z,[-Inf 0]);
quiver244(subs(dydt,a,1), -3, 3, -3, 3, 9, 'red');
hold off;
%We can see that there is an unstable equilibrium at y = +-1 and a stable
%equilibrium at y = 0.


%At these different parameters, the equilibrium solutions are different.
%More specifically, the stable equilibrium solutions follow y = +-sqrt(a) 
%when a>0, and there is an unstable equilibrium at y=0. When a
%is less than or equal to zero, two of the equilibrium solutions
%dissappear, and y=0 remains as an unstable equilibrium.
%This means that a=0 is the bifurcation point.

%% Question 5

bifDiag244(@(a,y) y.*(y.^2-a), -5.0, 5.0, -5.0, 5.0, 12);
%We know that according to the definition of a bifurcation point, f(a,y)
%must be equal to zero. But due to the implicity function theorem, this
%also implies that the partial derivative of f(a,y) in the direction of y
%is also zero. In order to show this, one must first realize that the
%contour plot needed to find the bifurcation point is the level curve of
%f(a,y)=0. One must also realize that the bifurcation point is when the
%curves of the contour plot intersect. According the the inverse function
%theorem, this cannot be the case unless that point is a critical point of
%the function, in which case the inverse function theorem does not apply. 
%This means that the gradient of the function f(a,y) equals
%zero at that point which implies that f_y(a,y) is equal to zero. However,
%this does not explain when bifurcation point occures at a vertical
%tangent. This is explained by the fact that at a vertical tangent, the
%gradient vector must be horizontal. This means that f_y(a,y) is equal to
%zero.

%Using the bifurcation diagram, we can see that when an area is blue, it
%has a positive slope, and when an area is red, it has a negative slope.
%When an area is black, it has zero slope. This shows that from the
%bifurcation diagram, we can see that equilibrium solutions for a certain
%value of a and determine if it is stable or unstable. In this example, at
%a = 4, we can see that at y = +-2 there are unstable equilibrium
%solutions and a stable equilibrium solution at y = 0. We can also see that
%there is a bifurcation point at a=0.

%% Question 6

bifDiag244(@(a,y) y.*(y-a+1), -5.0, 5.0, -5.0, 5.0, 13);

%According to the bifurcation diagram, there is a bifurcation point at a =
%1. This is because the lines contour plot intersects itself. At the
%bifurcation point, there is a semistable equilibrium at y = 0. Before that
%point, there is an unstable equilibrium solution at y = 0 and a stable
%equilibrium solution at y = a-1. After that point, there is an unstable
%equilibrium solution at y = a-1 and a stable equilibrium solution at y =
%0. From here one can see that the bifurcation point changes which
%equilibrium solution is stable and which is unstable.