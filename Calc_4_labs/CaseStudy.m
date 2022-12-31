syms x y
r = .1
t = sym('t');

xd = x.*(1-r*x-0.5*y); %Prey
%Now the prey compete for food

yd = y.*(-0.75 + 0.25*x);  %Preds



[xCrits, yCrits] = solve(xd == 0, yd == 0, [x,y]);

%Critical Points
%(0,0) %Saddle
%(1/r, 0) %Stable
%(3, -6r+2) %Asymptotically Stable 

J(x,y) = jacobian([xd, yd], [x,y]);

M00 = J(0,0);
Mr0 = J((1/r),0);
M3r = J(3, (-6*r+2));

[T00, D00] = eig(M00);
[Tr0, Dr0] = eig(Mr0);
[T3r, D3r] = eig(M3r);



%The 300 need to change quiver2d244 to accept an inputed number of points.
%It is line 19, you need to make the 30 into nVecs and make nVecs a new
%parameter.

%quiver2D244(@(x,y) x.*(1-(.1)*x-0.5*y) ,@(x,y) y.*(-0.75 + 0.25*x), -1, 5, -1, 5, 1, 'r',50)

initials = [2 3.5 .5 1 4 3 5 4.5; 3 .5 2 3 -1 2 4 0.1];
figure(2)
hold on
for i = [1:8]
    [xsol, ysol] = ode45(@(t,y) myODE(t,y,.1), [0 1000], initials(:,i));
    plot(ysol(:,1), ysol(:,2),'LineWidth', 2);
end
hold off


figure
hold on
[xsol, ysol] = ode45(@(t,y) myODE(t,y,.1), [0 50], [2;3]);
plot(xsol,ysol(:,1));
plot(xsol, ysol(:,2));

hold off

%If R = 0, it becomes a normal pred prey and one of the critical points is
%removed. That critical point is the one that would be used if there was no
%pred and it was just prey with limited resources.(Since y = 0). So it
%essentially boils down to a linear ode there.

%If R is greater than 1/3, then there is not enough resources, so little in
%fact that the preds would have to activly be making prey.




z = sym('z');


dx(x,y,z) = x.*(1-0.2.*x- 0.05*y - 0.5*z);
dy(x,y,z) = y.*(1-0.05*x-0.3*y-0.1*z);
dz(x,y,z) = z.*(-0.75+0.25*x+0.1*y);

[x3Crits, y3Crits, z3Crits] = solve(dx == 0, dy == 0, dz == 0, [x,y,z]);

x3Crits = double(x3Crits)
y3Crits = double(y3Crits)
zyCrits = double(z3Crits)

J3(x,y,z) = jacobian([dx, dy, dz], [x, y, z]);

MInspect = J3((25/13), (35/13), (25/26));

JSDA = J3(5, 0,0);
[T4, D4] = eig(JSDA);
T4 = double(T4)
D4 = double(D4)

[T3, D3] = eig(MInspect);
D3 = double(D3)
[A, B, C] = meshgrid(0:5, 0:5, 0:5);

figure
hold on
xlabel('Species x')
ylabel('Species y')
zlabel('Species z')
quiver3(A, B, C, dx(A,B,C), dy(A,B,C), dz(A,B,C));
[xsol, ysol] = ode45(@(t,y) myODE2(t,y), [0 40], [5 5 5]);
plot3(ysol(:,1), ysol(:,2), ysol(:,3));



hold off
figure
hold on
legend()
plot(xsol,ysol(:,1), 'DisplayName', 'Species x');
plot(xsol,ysol(:,2), 'DisplayName', 'Species y');
plot(xsol,ysol(:,3), 'DisplayName', 'Species z');

dx(x,y,z) = x.*(1-0.2.*x- 0.05*y - 0.5*z);
dy(x,y,z) = y.*(1-0.05*x-0.3*y-0.1*z);

quiver2D244(@(x,y) x.*(1-0.2.*x- 0.05*y),@(x,y) y.*(1-0.05*x-0.3*y), -0.5, 5, -0.5, 5, 5, 'r', 40);




%az = 6;
%el = 30;
%view([az,el])
%degStep = 5;
%detlaT = 0.1;
%fCount = 71;
%f = getframe(4);
%[im,map] = rgb2ind(f.cdata,256,'nodither');
%im(1,1,1,fCount) = 0;
%k = 1;

% spin right
%for i = 0:degStep:360
  %az = i;
  %axis([0 5 0 5 0 5])
  %view([az,el])
  %f = getframe(4);
  %im(:,:,1,k) = rgb2ind(f.cdata,map,'nodither');
  %k = k + 1;
%end

%imwrite(im,map,'Animation.gif','DelayTime',detlaT,'LoopCount',inf)

function Y = myODE(t,y, r)
    Y = zeros(2,1);
    Y(1) = y(1).*(1-r*y(1)-0.5*y(2));
    Y(2) = y(2).*(-0.75 + 0.25*y(1));
end

function Y = myODE2(t,y)
    Y = zeros(3,1);
    Y(1) = y(1).*(1-0.2*y(1)- 0.05*y(2) - 0.5*y(3));
    Y(2) = y(2).*(1-0.05*y(1)-0.3*y(2)-0.1*y(3));
    Y(3) = y(3).*(-0.75+0.25*y(1)+0.1*y(2));
end

function Y = myODE3(t,y)
    Y = zeros(2,1);
    Y(1) = y(1).*(1-0.2*y(1)- 0.05*y(2));
    Y(2) = y(2).*(1-0.05*y(1)-0.3*y(2));
end