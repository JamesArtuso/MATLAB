function quiver244(f, t_min, t_max, y_min, y_max, fNum, col)
% quiver244.m
% Author: Matt Charnley
%
% This function draws a quiver plot for the ODE dy/dt = f(t,y) for
% t_min <= t <= t_max and y_min <= y <= y_max. The function f should be
% passed in as an anonymous function, f = @(t,y) ... 
%
% The function draws this quiver plot in color col and saves it as figure number fNum,
% and also generates a normalized version (all vectors are the same length)
% as figure fNum+1, so that it can be accessed outside of this function.
% For this second figure, the magnitude of the arrows does not mean
% anything, but it is easier to see the direction of them. 
% so that it can be accessed outside of this function. It will start with
% hold on; and end with hold off;, so the figure needs to be cleared in the
% main file if needed.

nVecs = 30;
dt = (t_max - t_min)/nVecs;
dy = (y_max - y_min)/nVecs;

[t_vals, y_vals] = meshgrid(t_min:dt:t_max, y_min:dy:y_max);

vy = f(t_vals, y_vals)*dt/2;
vt = dt/2*ones(size(vy));

yn = vy./(sqrt(vt.^2 + vy.^2));
tn = vt./(sqrt(vt.^2 + vy.^2));

figure(fNum)
hold on;

quiver(t_vals,y_vals,vt,vy, col);
axis([t_min, t_max, y_min, y_max]);
axis square;
hold off;

figure(fNum+1)
hold on;

quiver(t_vals,y_vals,tn,yn,0.5, col);
axis([t_min, t_max, y_min, y_max]);
axis square;
hold off;
