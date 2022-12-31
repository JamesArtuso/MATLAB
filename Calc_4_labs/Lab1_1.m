%% Question 1
% Draw a direciton plot and IVP y(0) = -1 y(0) = 3
warning('off');
y = sym('y');t = sym('t');%Declare Variabels
dydt(t,y) = t-y.^2;%Declare first derive

quiver244(dydt,-5,5,-3,10,1,'red'); %Draw the direction field

%IVP with y(0) = 3
figure %Figure 3
hold on
[tSol1, ySol1] = ode23(@(t,y) t-y.^2,[0 5],3); %These two solve the
[tSol2, ySol2] = ode23(@(t,y) t-y.^2,[0 -5],3);%problem
plot(tSol1, ySol1,'red')
plot(tSol2, ySol2,'red')
axis([-5 5 -3 10])
hold off


%IVP with y(0) = -1
figure %FIGURE 4
hold on
[tSol1, ySol1] = ode23(@(t,y) t-y.^2,[0 5],-1);
[tSol2, ySol2] = ode23(@(t,y) t-y.^2,[0 -5],-1);
plot(tSol1, ySol1,'red')
plot(tSol2, ySol2,'red')
axis([-5 5 -3 10])
hold off

%% Question 2
% Draw a direciton plot and IVP -6 < y(0) < 5. Discuss what happens as t
% gets large
dydt(t,y) = y.*(y-5).*((y+2).^2).*(y+6);

quiver244(dydt,-5,5,-3,10,5,'red'); %Draw the direction field

%IVP with y(0) = 0
figure %Figure 7
hold on
[tSol1, ySol1] = ode23(@(t,y) y.*(y-5).*((y+2).^2).*(y+6),[0 10],0);
[tSol2, ySol2] = ode23(@(t,y) y.*(y-5).*((y+2).^2).*(y+6),[0 -10],0);
plot(tSol1, ySol1,'red')
plot(tSol2, ySol2,'red')
axis([-5 5 -3 10])
hold off

%IVP with y(0) = 4
figure %FIGURE 8
hold on
[tSol1, ySol1] = ode23(@(t,y) y.*(y-5).*((y+2).^2).*(y+6),[0 10],4);
[tSol2, ySol2] = ode23(@(t,y) y.*(y-5).*((y+2).^2).*(y+6),[0 -10],4);
plot(tSol1, ySol1,'red')
plot(tSol2, ySol2,'red')
axis([-5 5 -3 10])
hold off

%For y(0) = -6, -2, 0, or 5, the function is a line at that value.
%For values less than -6, as t gets large, y(t) approaches -infinity
%For values between -6 and -2, as t gets large, y(t) approaches -2
%For values between -2 and 0, as t gets large, y(t) approaches 0
%For values between 0 and 5, as t gets large, y(t) approaches 0
%For values greater than 5, as t gets large, y(t) approaches +infinity

%% Question 3
% Euler method of approximation

[j,Q] = eulerMethod(@(t,y) exp(t)-t, 0.00001, 2, 0, 1)
figure
plot(j,Q)

quife(lfg)

solY(t) = exp(t)-t;
dydt(t,y) = y+t-1;

tic
%Actual Solution
figure%Figure 9
[ts] = linspace(0, 10);
ys = solY(ts);
plot(ts, ys);
toc

tic
%dt = 1
figure %Figure 10
[ts, ys] = eulerMethod(dydt, 1, 10, 0, 1);
plot(ts, ys)
toc

tic
%dt = 0.1
figure %Figure 11
[ts, ys] = eulerMethod(dydt, 0.1, 10, 0, 1);
plot(ts, ys)
toc

tic
%dt = 0.0001
figure %Figure 12
[tLong, yLong] = eulerMethod(dydt, 0.0001, 10, 0, 1);
plot(tLong, yLong)
toc
%This taks about 875 seconds to complete

%Fron the figures, it is easy to see that as dt gets smaller, the
%approximation gets more accurate, however the time to compute gets much
%larger
%% Question 4
% Direction field and IVP with y(0) = -2, 0, 2, 4, 6. Also discuss what
% happens to y as t goes to infinity.
%4
dydt(t,y) = 2*y.*(1-(y./4));%Declare first derive

y0 = [-2 0 2 4 6];

figure %figure 13
hold on 
for i = 1:5
   [tSol1, ySol1] = ode23(@(t,y) 2*y.*(1-(y./4)),[0 3],y0(i));
   [tSol2, ySol2] = ode23(@(t,y) 2*y.*(1-(y./4)),[0 -2],y0(i));
   plot(tSol1, ySol1,'blue')
   plot(tSol2, ySol2,'blue')
end

quiver244(dydt,-5,5,-3,10,13,'red'); %Draw the direction field

hold off
%To find the solution analytically one must utilize the Bernoulli method of
%solving differential equations. This is because dydt = 2y-.5y^2. With z =
%y^-1, we get that y = (4e^2t)/((e^2t)+c).

%The value that y approaches as t goes to infinity depends on the the
%iniital value of y(0). This is because of the nature of this equation. It
%is a logistical equation which means that it has 2 equilibrium points.
%These two points are when dy/dt = 0, so these occure at y0 = 0 and y0 = 4.
%We also know that y0 = 4 is a stable equilibrium solution. This means that
%For y() = 0 or 4, as t goes to infinity y(t) is constant.
%For y(0) > 4, as t goes to infinity, y(t) approaches 4
%For 0<y(0)<4, as t goes to infinity, y(t) approaches 4
%For y(0) < 0, as t goes to infinity, y(t) approaches negative infinity.


%% Question 5
% Draw the direction field with particular solutions included. Find when
% the slope is tangent to the solution through (4,0) is vertical.

dydt(t,y) = (8.*t-(t.^3))./(8+(y.^3));%Declare first derive

t0 = [2 4 0];
y0 = [0 0 -2];

figure %figure 15
hold on
for(i = 1:3)
   [tSol1, ySol1] = ode23(@(t,y) (8*t-(t^3))/(8+(y^3)),[t0(i) 5],y0(i));
   [tSol2, ySol2] = ode23(@(t,y) (8*t-(t^3))/(8+(y^3)),[t0(i) -5],y0(i));
   plot(tSol1, ySol1,'blue')
   plot(tSol2, ySol2,'blue')
end

quiver244(dydt,-5,5,-3,10,15,'red'); %Draw the direction field
hold off

%We know that due to the (8+y^3) in the denominatior, the slope becomes
%undefined at y = -2. This also means that the function function has a
%vertical tangent at y = -2. This means that we must solve for y. This is
%realitivly easy since dydt is seperable.

%Finding y:
%8+y^3 = 8t - t^3
%8y+.25y^4 = 4t^2-.25t^4+c

%Finding c:
%8(0)+.25(0)^4 = 4(4)^2-.25(4)^4+c
%0 = 64-64+c
%c = 0

%Finding when y(t) = -2
%8(-2)+.25(-2)^4 = 4t^2-.25t^4+c
%0 = -.25t^4+4t^2+12
%x^2 = (-4-sqrt(16+12))/-.5
%We only need the negative due to the fact that the we are dealing with
%only real solutions
%x = +-sqrt(8+4sqrt(7)))
%This tells us that a vertical tangent occures at (+sqrt(8+4sqrt(7))), -2)
%and (-sqrt(8+4sqrt(7))),-2)


function [tVals, yVals] = eulerMethod(f, dt, Tf, t0, y0)
    tVals = t0:dt:Tf;
    yVals = zeros(size(tVals));
    yVals(1) = y0;
    for i = 1:(length(tVals)-1)
        yVals(i+1) = yVals(i) + dt*f(tVals(i), yVals(i));
    end
end