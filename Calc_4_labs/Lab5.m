%% Preperation
%James Artuso
%5/2/21
%Lab 5

x = sym('x');
y = sym('y');


dx = -(x-y).*(1-x-y);
dy = x.*(2+y);

%% I: Critical Points

[xCrits, yCrits] = solve(dx==0, dy==0,[x, y]);


criticals = double([xCrits, yCrits]);

%% II: Plot
quiver2D244(@(x,y) -(x-y).*(1-x-y), @(x,y) x.*(2+y), -4, 4, -4, 4, 1, 'red')

initials = [2 3.5 0 0 3 3 3.5 20; -1.45 -2.2 3 -3 -1 2 -2.02 0.1];
figure(2)
hold on
for i = [1:7]
    [xsol, ysol] = ode45(@(t,y) part1(t,y), [0 100], initials(:,i));
    plot(ysol(:,1), ysol(:,2),'LineWidth', 2);
end
hold off

%The same graph but zoomed out

quiver2D244(@(x,y) -(x-y).*(1-x-y), @(x,y) x.*(2+y), -65, 65, -65, 65, 3, 'red')

figure(4)
hold on
for i = [1:8]
    [xsol, ysol] = ode45(@(t,y) part1(t,y), [0 100], initials(:,i));
    plot(ysol(:,1), ysol(:,2),'LineWidth', 2);
end
hold off



%% III: Type of critical point

%(0,0): This appears to be a saddle based on the graph
%(0,1): This appears to be a stable spiral based on the graph
%(-2,-2): This appears to be an asymptotically stable node based on the
%graph
%(3,-2): This appears to be an unstable node based on the graph



%% IV: Behavior of the Trajectories

%The purple line has the initial conditions (0,3). This causes the line to
%be caught in the spiral that eventually leads to a stable solution at (0,1)

%The yellow lines begins at (3.5,2.2). The unstable node originally pushes
%out the line to the right and down, but the stable node eventually takes
%over and attracts the yellow line to (-2,-2)

%The dark blue line begins at (3.5, 2.02). The unstable pushes this line
%down and to the right, however unlike the yellow line this line continues
%onto infinity since the stable node is unable to attract it. This apparent
%repulsion could also be due to the limited capabilities of matlab, since
%if this value does eventually wrap around to (-2,-2), it would take a
%large value of t to acheive. 


%On the zoomed out plot, the brown line begins at (20, 0.1). 
%Similar to the dark blue line, this line appears to also seems to 
%increase to infinity. 

%The lime green line begins at (0,-3). This line is attracted towards
%(-2,-2)


%The light blue line begins at (3,-1). This line is repulsed by the
%unstable node at (3,-2). However, the saddle swings this lines around to
%the negative x side. The saddle at (0,0) then causes the line to be pushed
%towards (-2,-2) where it eventually is attracted to the asymptotically
%stable critical point at (-2,-2).

%The brown line on the zoomed in graph begins at (2, -1.45). This line is
%repulsed by the unstable node, and eventually is caught in the spiral at
%(0,1). Interestingly, while trying to graph this behavior, slight
%deviations from this point, such as beginning at (2,-1.4) would cause the
%line follow the behavior of the light blue line.


%Based on these trajectories, the asymptotically stable node seems to
%have a larger basin of attraction than the stable spiral.


%% V: Linearization
J(x,y) = jacobian([dx, dy], [x,y])

%M00 corresponds to (0,0)
M00 = double(J(xCrits(1), yCrits(1)));
disp('J(0,0)')
disp(M00)

%M01 corresponds to (0,1)
M01 = double(J(xCrits(2), yCrits(2)));
disp('J(0,1)')
disp(M01)

%MN2N2 corresponds to (-2,-2)
MN2N2 = double(J(xCrits(3), yCrits(3)));
disp('J(-2,-2)')
disp(MN2N2)

%M3N2 corresponds to (3,-2)
M3N2 = double(J(xCrits(4), yCrits(4)));
disp('J(3,-2)')
disp(M3N2)

%% VI: Eigenvalues

%(0,0)
[T00, D00] = eig(M00);
%The eigenvalues of this matrix are real and opposite signs. This indicates
%that the point (0,0) is a saddle
disp('Eigenvalues of J(0,0):')
disp(D00)

%@(0,1)
[T01, D01] = eig(M01);
%The eigenvalues of this matrix have complex values with negative real
%parts, indicating that the point (0,1) is a stable spiral
disp('Eigenvalues of J(0,1):')
disp(D01)

%@(-2,-2)
[TN2N2, DN2N2] = eig(MN2N2);
%The eigenvalues of this matrix are both real and negative, indicating that
%the point (-2,-2) is an asymptotically stable node
disp('Eigenvalues of J(-2,-2):')
disp(DN2N2)

%@(3,-2)
[T3N2, D3N2] = eig(M3N2);
%The eigenvalues of this matrix are both real and positive, indicating that
%the point (3,-2) is an unstable node
disp('Eigenvalues of J(3,-2):')
disp(D3N2)

%All the eigenvalues found correspond with the results of part III.

%% Function

function Y = part1(t,y)
    Y = zeros(2,1);
    Y(1) = -1*(y(1)-y(2))*(1-y(1)-y(2));
    Y(2) = y(1)*(2+y(2));
end