function quiver2D244(f,g, x_min, x_max, y_min, y_max, fNum, col, Vecs)
% quiver2D244.m
% Author: Matt Charnley
%
% This function draws a quiver plot for the ODE dx/dt = f(x,y), dy/dt = g(x,y) for
% x_min <= x <= x_max and y_min <= y <= y_max. The functions f and g should be
% passed in as an anonymous functions, f = @(x,y) ... 
%
% The function draws this quiver plot in color col and saves it as figure number fNum,
% and also generates a normalized version (all vectors are the same length)
% as figure fNum+1, so that it can be accessed outside of this function.
% For this second figure, the magnitude of the arrows does not mean
% anything, but it is easier to see the direction of them. 
%
% It will start with
% hold on; and end with hold off;, so the figure needs to be cleared in the
% main file if needed.

nVecs = Vecs;
dx = (x_max - x_min)/nVecs;
dy = (y_max - y_min)/nVecs;

[x_vals, y_vals] = meshgrid(x_min:dx:x_max, y_min:dy:y_max);

vx = f(x_vals, y_vals);
vy = g(x_vals, y_vals);

xn = vx./(sqrt(vx.^2 + vy.^2));
yn = vy./(sqrt(vx.^2 + vy.^2));

figure(fNum)
hold on;

quiver(x_vals, y_vals, vx, vy, 'Color',col);
axis([x_min, x_max, y_min, y_max]);
axis square;
hold off;

figure(fNum+1)
hold on;
quiver(x_vals,y_vals,xn,yn,0.8, 'Color', col);
axis([x_min, x_max, y_min, y_max]);
axis square;
hold off;
