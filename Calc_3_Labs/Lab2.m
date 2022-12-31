%% 1. Storing the Curve r(t) and the Final time T
% Both r and T final are stored as variables. r consists of a vector, while
% T final is a double value.
t = sym('t');
%r = [4*t*sin(4*t), 3*t+(64*t^3)/3, 4*t*cos(4*t)]; %Storing r(t) as a variable r
%r = [cos(pi*sin(t)), sin(pi*sin(t)), sin(t)];
r = [t^2,t^3,0];
Tf = 7; %Storing T final as a variable Tf



%% 2. Two plots of the curve r(t) showing the curve from different angles.
% This will be done by plotting a line which connects 2000 different points
% on r(t).

%The blue line is in the bounds
%The red line is out of the bounds

figure('Name','Graph 1 of r');
hold on
%Curve inside the bounds
x = linspace(0,7, 2000);
line(subs(r(1),t,x), subs(r(2),t,x), subs(r(3),t,x),'Color', 'blue'); 
%Curve outside the bounds
x = linspace(7,9, 200);
line(subs(r(1),t,x), subs(r(2),t,x), subs(r(3),t,x),'Color','red');
xlabel('X')
ylabel('Y')
zlabel('Z')
plot3(20,-20,0,'o');
%view(-20, 100);
%axis([-30 30 0 8000 -30 30]);
hold off
figure('Name','Graph 2 of r');
hold on
%Curve inside the bounds
x = linspace(0,7, 2000);
line(subs(r(1),t,x), subs(r(2),t,x), subs(r(3),t,x),'Color', 'blue'); 
%Curve outside the bounds
x = linspace(7,9, 200);
line(subs(r(1),t,x), subs(r(2),t,x), subs(r(3),t,x),'Color','red');
xlabel('X')
ylabel('Y')
zlabel('Z')
view(20,50);
axis([-30 30 0 8000 -30 30]);
hold off



%% 3. Code for an animation of a point moving around the curve
%Code for animating plot is in the function animatePlot


%% 4. Compute the length of this curve
% This is done by finding the magnitude of the velocity vector and
% integrating from 0 to Tf.

v = [t, t, t]; %Computation of the velocity vector
v(1) = diff(r(1));
v(2) = diff(r(2));
v(3) = diff(r(3));

vMag = simplify(sqrt((v(1)^2) + (v(2)^2) + (v(3)^2))); %Magnitude of the principal normal vector

a = [t, t, t]; %Computation of the acceleration vector
a(1) = diff(v(1));
a(2) = diff(v(2));
a(3) = diff(v(3));


crossing = magnitude(cross(v,a));

%This is the integral from 0 to t of the magnitude of v.
%The curve length at time t = 0 is zero.
arcLength = simplify(int(vMag,'t',0,'t'));


curveLength = simplify(subs(arcLength,'t',7))

%% 5. In words/equations, answer the following

%If I were to give you two values t = a and t = b, what would be the length
%of the curve r between these two points

%   -Given two values t = a and t = b, the length of the curve between these
%two points would be |arcLength(b)-arcLength(a)|. If you did not have an
%arc length formula, you could take the integral of velocity from 0 to b,
%and subtract it from the integral of velocity from 0 to a. The absolute
%value would be the length between the two.

%If your given curve r(t) is reparameterized by arc-length parameter s,
%with s = 0 at the initial point, what would be the bound s in this
%reparameterization?
%   -If the curve r was reparameterized by the arc-length parameterization s,
%the bounds could be found by plugging in the t bounds to the arcLength
%formula. In this lab, the s bounds would be

%sLower = subs(arcLength,'t', 0)
sUpper = subs(arcLength,'t',Tf)
%How would you find a unit tangent vector to the curve r(t)

%   -The unit tangent vector can be found by finding the unit vector of
%velocity. Velocity is the derivative of the curve r(t).

T = [t,t,t];
T(1) = simplify(v(1)/vMag);
T(2) = simplify(v(2)/vMag);
T(3) = simplify(v(3)/vMag);
disp('T =')
disp(T)

%% 6.Compute the tanget vector and unit tangent vector at the intial and end points
% This is found by evaluating the unit tangent vector at t = 0 and t = Tf


InitialTangent = subs(v, 't', 0)
FinalTangent = subs(v, 't', Tf)

InitialUnitTangent = simplify(subs(T,'t', 0))
FinalUnitTangent = simplify(subs(T, 't', Tf))

%% 7. Compute the principal (unit) normal vector at the inital and end points
% This is found by normalizing the perpendicular component of acceleration.
% The perpendicular component is found by multiplying vMag by T'(t)

N = [t, t, t]; % The N vector is calculated by normalizing the perpendicular component of a
                %This component is found by multiplying T'(t) by ||v(t)||


N(1) = diff(T(1)); %Finding T'(t)
N(2) = diff(T(2));
N(3) = diff(T(3));
N(1) = N(1)*vMag; %Finding aPerp
N(2) = N(2)*vMag;
N(3) = N(3)*vMag;
aPerpMag = magnitude(N); 
N(1) = simplify(N(1)/aPerpMag); %Normalizing aPerp
N(2) = simplify(N(2)/aPerpMag);
N(3) = simplify(N(3)/aPerpMag);

InitialUnitNormal = simplify(subs(N,'t', 0))
FinalUnitNormal = simplify(subs(N, 't', Tf))
%NOTE: Matlab is being weird and putting these at the end of the pdf.

%% Compute the binormal vector at the initial and end points

B = simplify(cross(T, N)); %B is found by crossing T and N
                           %T and N are the unit vectors of velocity and
                           %acceleration respectivly
B2 = simplify(cross(v,a)/magnitude(cross(v,a)));
                           
InitialUnitBinormal = simplify(subs(B,'t', 0))
FinalUnitBinormal = simplify(subs(B, 't', Tf))


%% Plot the unit tangent, principal and binormal vectors at the initial and end points
% I created a seperate function, plotSet, that will do this. It does this
% by plotting the lines that connect r(t) to either T(t), N(t), or B(t)


plotSet(r,T,N,B,0,'Initial Vectors');%Returns the T, N , B vectors a t = 0
plotSet(r,T,N,B,Tf,'Final Vectors'); %Returns the T, N , B vectors a t = Tf


%% 10. Compute the curvature at the initial and end points
% This is found by dividing the magnitude of the cross product of v and a
% by vMag^3.

curvature = simplify(magnitude(cross(v,a))/(vMag^3));

initialCurvature = simplify(subs(curvature,'t',0))%I had issues making these functions output so I used disp
finalCurvature = simplify(subs(curvature,'t',Tf))
%NOTE:Matlab refuses to display these functions when I publish them. Their
%values are
%initialCurvature = 32/25
%finalCurvature = (32*197^(1/2))/9865881

%animatePlot(r,T,N,B,0,.05,Tf);

%% TORSION
aPrime(1) = diff(a(1));
aPrime(2) = diff(a(2));
aPrime(3) = diff(a(3));
torsion = simplify(dot(cross(v,a),aPrime)/((vMag^6)*(curvature^2)));

%% Functions
function mag = magnitude(equation) %To make my code look neater and have less lines
    mag = simplify(sqrt((equation(1)^2) + (equation(2)^2) + (equation(3)^2)));
end

function crossProduct = cross(x,y)
    if(length(x) ~= 3 && length(y) ~= 3) %checks to see if the vectors are in |R^3
        error("Vectors are not of |R^3"); %Throw error if they are not in |R^3
    end
    crossProduct = [(x(2)*y(3)) - (x(3)*y(2)),-((x(1)* y(3)) - (x(3)*y(1))),(x(1)*y(2)) - (x(2)*y(1))]; %compute crossproduct
end

function [TAnswer, NAnswer, BAnswer] = plotSet(r,T,N,B,time,name)
    figure('Name',name);
    hold on
    view(121,15);
    x = linspace(time-1,time+1, 50);
    line(subs(r(1),'t',x), subs(r(2),'t',x), subs(r(3),'t',x));  
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    
    
    A = [subs(r(1),'t',time), subs(r(2), 't', time), subs(r(3), 't', time)];
    plot3(A(1), A(2), A(3), 'o');
    
    xView = [simplify((-5+A(1))) simplify((5+A(1)))];
    yView = [simplify((-5+A(2))) simplify((5+A(2)))];
    zView = [simplify((-5+A(3))) simplify((5+A(3)))];
    axis(double([xView yView zView]));
    
    %Unit Tangent Vector
    TAnswer = [subs(T(1), 't', time), subs(T(2), 't', time), subs(T(3), 't', time)];
    plot3(A(1)+TAnswer(1), A(2)+TAnswer(2), A(3)+TAnswer(3), 'o');
    xyz = vertcat(A, simplify(A+TAnswer));
    line(xyz(:,1),xyz(:,2),xyz(:,3),'Color','yellow');
    
    %Principal Normal Vector
    NAnswer = [subs(N(1), 't', time), subs(N(2), 't', time), subs(N(3), 't', time)];
    plot3(A(1)+NAnswer(1), A(2)+NAnswer(2), A(3)+NAnswer(3), 'o');
    xyz = vertcat(A, simplify(A+NAnswer));
    line(xyz(:,1),xyz(:,2),xyz(:,3),'Color','green');
    
    %Binormal Vector
    BAnswer = [subs(B(1), 't', time), subs(B(2), 't', time), subs(B(3), 't', time)];
    plot3(A(1)+BAnswer(1), A(2)+BAnswer(2), A(3)+BAnswer(3), 'o');
    xyz = vertcat(A, simplify(A+BAnswer));
    line(xyz(:,1),xyz(:,2),xyz(:,3),'Color','red');
    hold off
end

function plotting = animatePlot(r,T,N,B,t0,speed, tf)
    figure('Name','Animated Plot')
    hold on;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    view([100 70]);
    for i = t0:speed:tf
        
        x = linspace(i-2,i+2, 50);
        rLine = line(subs(r(1),'t',x), subs(r(2),'t',x), subs(r(3),'t',x));
        
        A = [subs(r(1),'t',i), subs(r(2), 't', i), subs(r(3), 't', i)];
        APoint = plot3(A(1), A(2), A(3), 'o'); %This plots an animated point on the curve
        
        
        %Unit Tangent Vector
        TLength = [subs(T(1), 't', i), subs(T(2), 't', i), subs(T(3), 't', i)];
        TPoint = plot3(A(1)+TLength(1), A(2)+TLength(2), A(3)+TLength(3), 'o');
        xyz = vertcat(A, simplify(A+TLength));
        TLine = line(xyz(:,1),xyz(:,2),xyz(:,3),'Color','yellow');
        
        %Principal Normal Vector
        NLength = [subs(N(1), 't', i), subs(N(2), 't', i), subs(N(3), 't', i)];
        NPoint = plot3(A(1)+NLength(1), A(2)+NLength(2), A(3)+NLength(3), 'o');
        xyz = vertcat(A, simplify(A+NLength));
        NLine = line(xyz(:,1),xyz(:,2),xyz(:,3),'Color','green');
        
        %Binormal Vector
        BLength = [subs(B(1), 't', i), subs(B(2), 't', i), subs(B(3), 't', i)];
        BPoint = plot3(A(1)+BLength(1), A(2)+BLength(2), A(3)+BLength(3), 'o');
        xyz = vertcat(A, simplify(A+BLength));
        BLine = line(xyz(:,1),xyz(:,2),xyz(:,3),'Color','red');
        
        
        xView = [simplify((-5+A(1))) simplify((5+A(1)))];
        yView = [simplify((-5+A(2))) simplify((5+A(2)))];
        zView = [simplify((-5+A(3))) simplify((5+A(3)))];
        axis(double([xView yView zView]));
        
        drawnow;
        
        delete(rLine);
        delete(APoint);
        delete(TPoint);
        delete(TLine);
        delete(NPoint);
        delete(NLine);
        delete(BPoint);
        delete(BLine);
    end
    hold off;
end

function dotProduct = dot(x,y) %function for dot product
    if(length(x) ~= length(y)) %checks to see if the vectors are not of the same dimension 
        error("Length of vectors are not equal"); %throw error if not equal
    end
    dotProduct = 0; %compute dot product otherwise
    for i = 1:length(x) %for loop acts as a summation
       dotProduct = dotProduct + (x(i)*y(i));
    end
end
