function bifDiag244(f, a_min, a_max, y_min, y_max, fNum)
% bifDiag244.m
% Author: Matt Charnley
%
% This function draws a bifurcation diagram for the ode dy/dt = f(alpha, y)
% with parameter alpha running from a_min to a_max. It draws this graph in
% figure fNum, and will not overwrite the figure there.
%
% The black marks are for equilibrium solutions, the blue regions are where
% the solution will tend upwards, and the red region is where it will tend
% downwards.

NLines = 100;
da = (a_max - a_min)/NLines;
dy = (y_max-y_min)/NLines;

opt = optimset('Display', 'off');

figure(fNum);
hold on;
for a_test = a_min:da:a_max
    [possSols, ~, flag] = fsolve(@(s) f(a_test, s), linspace(y_min, y_max, 25), opt);
    eqSols = [];
    if flag >= 0
        eqSols = unique(possSols);
    end
    for y_test = y_min:dy:y_max
        if f(a_test, y_test) > 0
            plot(a_test, y_test, 'b.', 'MarkerSize', 4);
        elseif f(a_test, y_test) < 0
            plot(a_test, y_test, 'r.', 'MarkerSize', 4);
        end
    end
    for solT = 1:length(eqSols)
        plot(a_test, eqSols(solT), 'k.', 'MarkerSize', 4);
    end
end
hold off;
