function samplePlots244(f, t_min, t_max, y_min, y_max, t_0, y_0, fNum, col)
% samplePlots244.m
% Author: Matt Charnley
%
% This function takes the ODE dy/dt = f(t,y) and plots sample solutions
% with initial value (t_0, y_0). It uses ode45 to sketch out the solutions.
% t_0 must be between t_min and t_max.
% The input y_0 can be a vector of initial values, and this function will
% plot a curve for each of those values. If using a vector of initial
% conditions, the function must be written with vector element-wise
% operations.
%
% It plots the graphs on figure fNum in color col. It starts with hold on
% and ends with hold off, so the figure will not be cleared. 

t_right = t_0;
t_left = t_0;
y_right = y_0;
y_left = y_0;
if t_max > t_0
[t_right, y_right] = ode23(f, [t_0, t_max], y_0);
end
if t_min < t_0
[t_left, y_left] = ode23(f, [t_0, t_min], y_0);
end

L = length(y_0);
t_sol = [flip(t_left); t_right];

for ind = 1:L
    y_sol(:,ind) = [flip(y_left(:,ind)); y_right(:,ind)];
end

figure(fNum);
hold on;

for ind=1:L
    plot(t_sol, y_sol(:,ind), col);
end
axis([t_min, t_max, y_min, y_max]);
hold off;


