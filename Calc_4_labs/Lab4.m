%% Lab 4
%James Artuso
%4/18/2021
%% 1A
A = [-1,-3;2,-2;3,-1];
B = [1,0,-1;3,-1,2];
M1 = B*A;
M2 = A*B;
M3 = inv(M1);
%M2^-1 is not well defined. This is because it is not a linearly
%independant matrix. We can prove that for any mxn matrix A, and nxm
%matrix B, if m > n, AB is not ivertible. First, define
%A = A11   A12    A1n    [Row1A,
%    A21   A22    A2n  =  Row2A,
%    ..                   ...,
%    Am1   Am2    Amn     RowmA]
%B= B11    B12    B1m   
%   B21    B22    B2m  = [Col1B, Col2B, ..., ColmB]
%   ..
%   Bn1    Bn2    Bnm
%Thus, their product is
%   Row1A*Col1B   Row1A*Col2B ... Row1A*ColmB
%   Row2A*Col1B   Row2A*Col2B ... Row2A*ColmB
%   ...
%   RowmA*Col1B   RowmA*Col2B ... RowMaColmB
%One can see that the resulting matrix is a linear combination of the
%columns of B. In addition, one knows that B only spans |R^n assuming the
%best case that B is invertible. This means that the product must also only
%span |R^n since it is made up of |R^n vectors. This is less than its
%dimension though, so the product must be not invertible since it does not
%span the entire dimension |R^m.

disp(M1)
disp(M2)
disp(M3)



%% 1B
[T1, D1] = eig(M1);
[T2, D2] = eig(M2);
[T3, D3] = eig(M3);
%Comparing the eigenvalues and eigenvectors for M1 and M3, one can see that
%they share eigenvectors. However, the corresponding eigenvaules are
%reciprocals of eachother. So lambda1 for M1 is equal to 1/lambda1 form M3
%and so on. This makes sense since M3 is the inverse of M1.
disp(T1)
disp(D1)
disp(T2)
disp(D2)
disp(T3)
disp(D3)



%% 1C
t = sym('t');
EM1 = expm(M1*t);
EM1 = simplify(EM1);
DEM1 = diff(EM1,t);
DEM1_2 = M1*EM1;

disp(EM1)

Sol = simplify(DEM1-DEM1_2);
%If the Sol is equal to zero, then they are the same.
disp(Sol)



%% 2A
syms y1(t) y2(t)
Y =[y1;y2];
odes = diff(Y) == M1*Y;
C = Y(0) == [-3;2];
[y1Sol(t), y2Sol(t)] = dsolve(odes,C);

tspace = linspace(0,10,200);
figure('Name', "2A");
hold on
plot(tspace,y1Sol(tspace));
plot(tspace,y2Sol(tspace));
hold off
%This graph makes sense when one looks at the eigenvalues of M1. Both
%eigenvalues are negative, so the graph on the y1-y2 plane should be a
%stable node. On the t-y plane, both graphs approach zero as t goes to
%infinity. This makes sense because this would produce a stable node. These
%graphs also do not oscilate, so they cannot be spirals that tend towards
%zero.

%% 2B
M4 = [1, -2; -2, 1];
M5 = [4, 0; 3, 5];
M6 = [-2, -1; 1, -1];
%% 2B M4

%one positive one negative eigenvalues
part2(M4, -5, 5, -5, 5, 'M4',2);
%This is a saddle due to the differernt signs
%Eigenvalues: -1, 2. The results of the graph make sense when taking this
%into account.

%% 2b M5

%2 positive eigenvalues
part2(M5, -5, 5, -5, 5, 'M5',7);
%This is an unstable node due to the positive eigenvalues
%Eigenvalues: 5, 4. The results of the grap make sense when this is taken
%into account. One can see the direction field pointing away from the
%origin.

%% 2b M6

%Imaginary eigenvalues
part2(M6, -5, 5, -5, 5, 'M6',12);
%This is a spiral due to the complex eigenvalues
%Eigenvalues: (-3+-isqrt(5))/2. The results of the graph make sense when
%taking this into account. The direction field is in a spiral shape. In
%addition, it is a stable spiral since the real part of the solution is
%negative.


%% 2b function

function fig = part2(M, x1, x2, y1, y2, name, num)
    t = sym('t');
    syms Y1(t) Y2(t);
    matexpo = expm(M*t);
    Cs = [0, 1, 2; -1, 0 , -.5];
    ts =  linspace(x1,x2, 200);
    fig = figure('Name',name);
    axis([x1 x2 y1 y2]);
    hold on
    for i = [1:3]
        C = Cs(:,i);
        ySols = matexpo*C;
        y1Sol(t) = ySols(1);
        y2Sol(t) = ySols(2);
        plot(y1Sol(ts), y2Sol(ts));
    end
    
    %[A,B] = meshgrid(x1:.1:x2, y1:.1:y2);
    %quiver(A,B, M(1,1)*A + M(1,2)*B, M(2,1)*A + M(2,2)*B, 'Color', [126/255,47/255,142/255]);
    quiver2D244(@(Y1, Y2) M(1,1)*Y1 + M(1,2)*Y2, @(Y1, Y2) M(2,1)*Y1 + M(2,2)*Y2,x1,x2,y1,y2,num, [126/255,47/255,142/255]);
    %Note, if you plan on running this code yourself, I modified
    %quiver2D244.m to accept colors.This was done by changing line 34 to
    %quiver(x_vals, y_vals, vx, vy, 'Color',col); and changing line 41 to
    %quiver(x_vals,y_vals,xn,yn,0.8, 'Color', col); I left in the last to
    %lines so you would not have to do that.
    hold off
    for i = [1:3]
        figure('Name',strcat("t-y plane i",string(i)," ", name));
        axis([0 5 -3 3])
        hold on
        ts = linspace(0,x2,200);
        C = Cs(:,i);
        ySols = matexpo*C;
        y1Sol(t) = ySols(1);
        y2Sol(t) = ySols(2);
        plot(ts, y1Sol(ts));
        plot(ts, y2Sol(ts));
         hold off
    end

    
end
