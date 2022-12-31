%James Artuso
%Due 9/13/20

%Question 1
%p = (18, 10, 14)
%q = (23, 14, 20)
%r = (20, 5, 19)

p = [18, 10, 14]; %Storing the points as arrays
q = [23, 14, 20]; % where index 1 = x, index 2 = y
r = [20, 5, 19] ; % , and index 3 = z

pq = q-p; %calculating the vector pq
fprintf('pq: %s\n', sprintf('%d ', pq)); %print answer to command window
pr = r-p;%calculating the vector pr
fprintf('pr: %s\n', sprintf('%d ', pr)); %print answer to command window



pqprdot = dot(pq, pr);

%Question 3
%This was done before 2 in order to reduce the number of computations
%needed to do
v = cross(pq, pr);%v is the resulting vector from the cross prouct of pq and pr.
                    %It is a vector that is orthogonal to both pq and pr
                    %and results in a right-hand basis. It also represents
                    %the normal vector of the plane that is formed by pq
                    %and pr.
fprintf('v: %s\n', sprintf('%d ', v)); %print answer to command window
                    
%Question 2
theta1 = acosd(pqprdot/(mag(pq)*mag(pr))); %this works because a·b=||a||||b||cos(theta)
fprintf('theta1~ %s\n', sprintf('%.4f ', theta1)); %print answer to command window

theta2 = asind(mag(v)/(mag(pq)*mag(pr)));%this works because ||axb|| = ||a||||b||sin(theta)
fprintf('theta2~ %s\n', sprintf('%.4f ', theta2)); %print answer to command window

%Question 4
figure
hold on
view(-70,70) %changes the viewing angle of the graph based on azimuth and elevation angles
polygonMatrix = [p(:), q(:), r(:)]; %Make a matrix so that the x,y,z values of each vector
                                    %are put into a single vector for fill3
                                    %command
fill3(polygonMatrix(1,:),polygonMatrix(2,:), polygonMatrix(3,:),'red');%This draws the triangle on the graph



t = 0:0.001:1; %this sets up an equation to draw the normal vector line
deltaX = (t*v(1)+p(1));
deltaY = (t*v(2)+p(2));
deltaZ = (t*v(3)+p(3));
plot3(deltaX, deltaY, deltaZ,'-',p(1), p(2), p(3),'-o', v(1), v(2), v(3),'-o');%this plots the normal vector

hold off

figure %all of this redraws the triangle from a different angle
hold on
view(0,20)
fill3(polygonMatrix(1,:),polygonMatrix(2,:), polygonMatrix(3,:),'red');
plot3(deltaX, deltaY, deltaZ,'-',p(1), p(2), p(3),'-o', p(1)+v(1), p(2)+v(2), p(3)+v(3),'-o');
hold off



%Question 5
%The values of the normal vector can be used 
%as the coefficients in the standard for of 
%a plane in R^3
syms x y z
P = [x,y,z];
planefunction = dot(v, P-p);%This calculates the plane and puts it
                            %in and ax+by+cz+d format

% 0 = v(1)(x-p(1)) + v(2)(y-p(2)) + v(3)(x-p(3))
fprintf('0 = v(1)(x-p(1)) + v(2)(y-p(2)) + v(3)(x-p(3))\n') %prints answer to command window
% 0 = 50(x-18) -13(y-10) -33(z-14)
fprintf('0 = 50(x-18) -13(y-10) -33(z-14)\n') %prints answer to command window
% 308 = 50x -13y -33z
fprintf('308 = 50x -13y -33z\n') %prints answer to command window
% <50, -13, -33> · <x,y,z> = 308
fprintf('<50, -13, -33> · <x,y,z> = 308\n') %prints answer to command window


function dotProduct = dot(x,y) %function for dot product
    if(length(x) ~= length(y)) %checks to see if the vectors are not of the same dimension 
        error("Length of vectors are not equal"); %throw error if not equal
    end
    dotProduct = 0; %compute dot product otherwise
    for i = 1:length(x) %for loop acts as a summation
       dotProduct = dotProduct + (x(i)*y(i));
    end
end

function crossProduct = cross(x,y)
    if(length(x) ~= 3 && length(y) ~= 3) %checks to see if the vectors are in |R^3
        error("Vectors are not of |R^3"); %Throw error if they are not in |R^3
    end
    crossProduct = [(x(2)*y(3)) - (x(3)*y(2)),-((x(1)* y(3)) - (x(3)*y(1))),(x(1)*y(2)) - (x(2)*y(1))]; %compute crossproduct
end

function magnitude = mag(x)
    magnitude = 0;
    for i = 1:length(x) %for loop acts as summation
        magnitude = magnitude + (x(i)*x(i));
    end
    magnitude = sqrt(magnitude);
end