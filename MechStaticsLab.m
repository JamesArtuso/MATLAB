P1 = 109;%113;
w = 2400;%2040;
h = 18.6;%18.8;

A = [0,0,0];
B = [34.5,0,0];
C = [65.3,0,0];
D = [101.4,0,0];
E = [138.1,0,0];
F = [173,0,0];
G = [173,h,0];
H = [150,h,0];
I = [122,h,0];
J = [93.5,h,0];
K = [65.3,h,0];
L = [37.1,h,0];
M = [0,h,0];



dir1 = [0,1,0];
dir2 = normalize([37.1,h,0]);
dir3 = normalize([2.6,h,0]);
dir4 = normalize([30.8,h,0]);
dir5 = normalize([0,1,0]);
dir6 = normalize([28.2,h,0]);
dir7 = normalize([7.9,-h,0]);
dir8 = normalize([20.6,h,0]);
dir9 = normalize([16.1,-h,0]);
dir10 = normalize([11.9,h,0]);
dir11 = normalize([23,-h,0]);
dir12 = [0,1,0];
dir13 = [1,0,0];
dir14 = [1,0,0];
dir15 = [1,0,0];
dir16 = [1,0,0];
dir17 = [1,0,0];
dir18 = [1,0,0];
dir19 = [1,0,0];
dir20 = [1,0,0];
dir21 = [1,0,0];
dir22 = [1,0,0];
dir23 = [1,0,0];

dirs = [dir1;dir2;dir3;dir4;dir5;dir6;dir7;dir8;dir9;dir10
    ;dir11;dir12;dir13;dir14;dir15;dir16;dir17;dir18;dir19;dir20
    ;dir21;dir22;dir23];



Bx = sym('Bx');
By = sym('By');
Ef = sym('Ef');

F1 = [0,0,0];

F1 = F1 +[0,-w,0];
F1 = F1 + Bx*[1,0,0] + By*[0,1,0];
F1 = F1 + Ef*[0,1,0];

M1 = [0,0,0];
M1 = M1 + findMoment([0,0,0],P1*[1,0,0]);
M1 = M1 + findMoment([0,0,0],[0,-w/6,0]);

M1 = M1 + findMoment([34.5,0,0],[0,-w/6,0]);
M1 = M1 + Bx*findMoment([34.5,0,0],[1,0,0]);
M1 = M1 + By*findMoment([34.5,0,0],[0,1,0]);
M1 = M1 + findMoment([34.5,0,0],P1*dirs(3,:));

M1 = M1 + findMoment([65.3,0,0],P1*dirs(6,:));
M1 = M1 + findMoment([65.3,0,0],P1*dirs(5,:));
M1 = M1 + findMoment([65.3,0,0],[0,-w/6,0]);

M1 = M1 + findMoment([101.4,0,0],P1*dirs(8,:));
M1 = M1 + findMoment([101.4,0,0],-1*P1*dirs(7,:));
M1 = M1 + findMoment([101.4,0,0],[0,-w/6,0]);

M1 = M1 + findMoment([138.1,0,0],P1*dirs(10,:));
M1 = M1 + Ef*findMoment([138.1,0,0],[0,1,0]);
M1 = M1 + findMoment([138.1,0,0],[0,-w/6,0]);

M1 = M1 + findMoment([173,0,0],-1*P1*dirs(23,:));
M1 = M1 + findMoment([173,0,0],[0,-w/6,0]);

M1 = M1 + findMoment([0,h,0],P1*dirs(13,:));

M1 =  M1 + findMoment([37.1,h,0],-1*P1*dirs(3,:));

M1 = M1 + findMoment([65.3,h,0],-1*P1*dirs(5,:));

M1 = M1 + findMoment([93.5,h,0],1*P1*dirs(7,:));
M1 = M1 + findMoment([93.5,h,0],-1*P1*dirs(6,:));

M1 = M1 + findMoment([122,h,0],-1*P1*dirs(8,:));

M1 = M1 + findMoment([150,h,0],-1*P1*dirs(10,:));

M1 = M1 + findMoment([173,h,0],-1*P1*dirs(18,:));


[Bx, By, Ef] = solve(F1 == 0, M1 == 0, [Bx, By, Ef]);
FB = [double(Bx),double(By),0]
FE = [0,double(Ef),0]




mem18 = sym('mem18');
mem11 = sym('mem11');
mem23 = sym('mem23');

F2 = [0,0,0];

F2 = F2 +[0,-5*w/6,0];
F2 = F2+FB+FE;
F2 = F2 + mem18*[1,0,0];
F2 = F2 + mem11*(1)*dirs(11,:);
F2 = F2 + mem23*[1,0,0];
F2 = F2 + P1*[2,0,0];
%F2 = F2 + (1)*P1*dirs(7,:);

M2 = [0,0,0];

M2 = M2 + mem18*findMoment(H-B,[1,0,0]);
M2 = M2 + mem11*findMoment(H-B,(1)*dirs(11,:));
M2 = M2 + mem23*findMoment(E-B, 1*dirs(23,:));


M2 = M2 + findMoment(A-B, P1*[1,0,0]);
M2 = M2 + findMoment(A-B,[0,-w/6,0]);

M2 = M2 + findMoment(B-B,[0,-w/6,0]);
M2 = M2 + findMoment(B-B,FB);
M2 = M2 + findMoment(B-B,P1*dirs(3,:));

M2 = M2 + findMoment(C-B,P1*dirs(6,:));
M2 = M2 + findMoment(C-B,P1*dirs(5,:));
M2 = M2 + findMoment(C-B,[0,-w/6,0]);

M2 = M2 + findMoment(D-B,P1*dirs(8,:));
M2 = M2 + findMoment(D-B,-1*P1*dirs(7,:));
M2 = M2 + findMoment(D-B,[0,-w/6,0]);

M2 = M2 + findMoment(E-B,P1*dirs(10,:));
M2 = M2 + findMoment(E-B,FE);
M2 = M2 + findMoment(E-B,[0,-w/6,0]);

%M2 = M2 + findMoment(F-B,-1*P1*dirs(23,:));
%M2 = M2 + findMoment(F-B,[0,-w/6,0]);

M2 = M2 + findMoment(M-B,P1*dirs(13,:));

M2 =  M2 + findMoment(L-B,-1*P1*dirs(3,:));

M2 = M2 + findMoment(K-B,-1*P1*dirs(5,:));

M2 = M2 + findMoment(J-B,1*P1*dirs(7,:));
M2 = M2 + findMoment(J-B,-1*P1*dirs(6,:));

M2 = M2 + findMoment(I-B,-1*P1*dirs(8,:));

M2 = M2 + findMoment(H-B,-1*P1*dirs(10,:));

%M2 = M2 + findMoment(G-B,-1*P1*dirs(18,:));

[mem18, mem11, mem23] = solve(F2 == 0, M2 == 0, [mem18, mem11, mem23]);
mem18 = double(mem18)
mem11 = double(mem11)
mem23 = double(mem23)



function moment = findMoment(r,f)
    moment = cross(r,f);
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

function norm = normalize(x)
    norm = x/mag(x);
end