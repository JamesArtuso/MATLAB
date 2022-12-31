%% Setup
% Setting up variables used throughout the lab.

% James Artuso
% 10/30/2020
w = sym('w');
assume(w, 'real')
x = sym('x');
assume(x, 'real')
y = sym('y');
assume(y, 'real')
z = sym('z');
assume(z, 'real')
L = sym('L');
assume(L,'real');
%% Storing the two functions f and g
% This is done by declaring them as symbolic variables. I did not declare
% them as a symbolic functions since I prefer to work with them as variables
% rather than functions.

f = 3.0*w+5.0*w*z-5.0*x*y;
g = 0.3099*w*z+0.5753*(w^2)+0.6055*(x^2)+0.5319*(y^2)+0.2606*(z^2);


%% Finding (and displaying) all possible 'interior' critical points by finding the points where the (4-dimensional) gradient of f is zero. Determine which of these functions lie within the constrained region.
% This is done by using the gradient and solve commands. The gradient
% command should produce a 4d vector since there are four different partial
% derivatives. With the gradient, I used the solve command to find when
% all four of the partials are equal to zero. I then iterate through all
% the possible interor critical points and remove the ones that lie outside
% of the boundary.

fGrad = gradient(f, [w x y z]);
gGrad = gradient(g, [w x y z]);


[critW, critX, critY, critZ] = solve(fGrad == 0, [w,x,y,z]);  %Interior Points

disp('Interior Point(s): ')
for i = 1:length(critW) %This prints all critical points
   fprintf('[%f, %f, %f, %f] \n', critW(i), critX(i), critY(i), critZ(i))
end

disp('Validating if the critical points are within the boundary:')
for i = 1:length(critW)
    fprintf('g(%f, %f, %f, %f) = %s <= 1 \n', critW(i), critX(i), critY(i), critZ(i), subs(g, [w,x,y,z], [critW(i), critX(i), critY(i), critZ(i)]))
    if(subs(g, [w,x,y,z], [critW(i), critX(i), critY(i), critZ(i)]) > 1) %checks to see if a point is within the boundary
        sprintf('The point [%f, %f, %f, %f] is not in the boundary\n', critW(i), critX(i), critY(i), critZ(i))
        critW(i) = []; % removes the point if it is not in the boundary
        critX(i) = [];
        critY(i) = [];
        critZ(i) = []; 
    else
        fprintf('The point [%f, %f, %f, %f] is in the boundary\n', critW(i), critX(i), critY(i), critZ(i))
    end
end

%This prints all of the valid critical points with the given the boundary
disp('Valid Interior Points:')
for i = 1:length(critW)
   fprintf('[%f, %f, %f, %f] \n', critW(i), critX(i), critY(i), critZ(i))
end


%% Use Lagrange multipliers (again in 4-dimensions) to determine the potential critical points along the boundary g(w,x,y,z) = 1.
% This is done by using the solve command. It solves a system of equations
% consisting of 5 equations. 4 of these equations are given by the Lagrange
% multiplier method, while the last equation is g(w,x,y,z) = 1

[LSols, wSols, xSols, ySols, zSols] = solve([fGrad(1) == L*gGrad(1),fGrad(2) == L*gGrad(2),fGrad(3) == L*gGrad(3),fGrad(4) == L*gGrad(4), g == 1], [L,w,x,y,z]);

%The following will print all of the Lagrange points.
disp('Lagrange Points: ')
for i = 1:length(LSols)
    fprintf('[%f, %f, %f, %f] \n', wSols(i), xSols(i), ySols(i), zSols(i))
end

%% Find the value of f at each of these points, determine the maximum and minimum value, along with at which of the critical points it is attained
% I first add the list of interior points to the list of points along the
% boundary. This is because the location of points is no longer important.
% I only have to find the value of f at these points. This is done with a
% for loop. I store the values of each point in a corresponding index of
% the vals variable. I then find the max and min of the vals variable. With
% the max and min, I use logical indexing to find what points produce the
% max and min.

wSols = [double(wSols);double(critW)]; %Combining the critical points and 
xSols = [double(xSols);double(critX)]; %the boundary points
ySols = [double(ySols);double(critY)];
zSols = [double(zSols);double(critZ)];

vals = zeros(1,length(wSols));

for i = 1:length(wSols) %Evaluates f at each potential max and min
   vals(i) = subs(f, [w,x,y,z], [wSols(i), xSols(i), ySols(i), zSols(i)]);
end

%The following will print all potential minimum and maximum
disp('The value of all potential min/max points: ')
for i = 1:length(vals)
    fprintf('f(%f, %f, %f, %f) = %f \n', wSols(i), xSols(i), ySols(i), zSols(i), vals(i))
end


maximum = max(vals);%Finds the max of f on g
minimum = min(vals);%Finds the min of f on g

maxIndex = vals == maximum;%Logical indexing for the maximum value
minIndex = vals == minimum;%Logical indexing for the minimum value

fprintf('f(w,x,y,z) attains a maximum of %f at [%f, %f, %f, %f] \n', maximum, wSols(maxIndex),xSols(maxIndex), ySols(maxIndex), zSols(maxIndex))
fprintf('f(w,x,y,z) attains a minimum of %f at [%f, %f, %f, %f] \n', minimum, wSols(minIndex),xSols(minIndex), ySols(minIndex), zSols(minIndex))
