%% INFORMATION
%The following code has the funcitons 
%lab1sim
%lab1est
%included at the bottom of the .m file.
%James Artuso
%202008796
%06/24/22

%% Setting Global Variables

A = 0.5;
B = 100;
L = 100;
%% 2.1 B
sig = @(t) 1000.*cos(880.*pi.*(t)).*heaviside(t);


%% 2.1 C

Fs = 44.1*1000;
calculateDelay(A,B,L)
calculateDelay(2*A,B,L)


samplingX = (min(calculateDelay(A,B,L),calculateDelay(2*A,B,L))-0.01):1/Fs:(max(calculateDelay(A,B,L),calculateDelay(2*A,B,L))+0.01);
t1 = calculateDelay(A, B,L)
t2 = calculateDelay(2*A, B,L)
y1 = @(t)sig(t-calculateDelay(A, B,L));
y2 = @(t)sig(t-calculateDelay(2*A, B,L));
figure('Name',"2.1 c");
a1 = subplot(2,1,1);
plot(samplingX, y1(samplingX));
title('y1(t) and y2(t)');
a1.XLabel.String = 'time';
a1.YLabel.String = 'y1';
ylabel('y1')
a2 = subplot(2,1,2);
plot(samplingX, y2(samplingX));
a2.XLabel.String = 'time (seconds)';
a2.YLabel.String = 'y1';
ylabel('y2')



%% 2.2 B

x2 = 0:1/Fs:0.5;

y1n = y1(x2);
y2n = y2(x2);

figure('Name', "2.2 b")
[C, lags] = xcorr(y1n, y2n);

plot(lags/Fs, C);
title('C vs lags/Fs');
xlabel('lags/Fs');
ylabel('C');

%% 2.3 A

maxC = max(C);
lagIndex = find(C == maxC);
lag = lags(lagIndex)/Fs

%% 2.3 C

x = linspace(1, 100 ,100);
error = zeros(1,length(x));
index = 1;
for i = x
   [yt1, yt2] = lab1sim(0.5, 100, i, sig);
   [anglet, Lt] = lab1est(0.5,100,yt1, yt2);
   error(index) = 1-(Lt/i);
   index = index + 1;
end
figure('Name', "2.3 c")
plot(x, error)
title('Relative error');
xlabel('True L (meters)');
ylabel('Relative difference between true L and estimated L');

%% 2.4 A

%Noise
[y1, y2] = lab1sim(A, B, L, sig);
a = 10000;
z1 = @(t)y1(t)+a*randn(1,length(t));
z2 = @(t)y2(t)+a*randn(1,length(t));
z1x = z1(samplingX);
[angles, Ls] = lab1est(0.5, 100, z1, z2);
%% 2.4 B

[Ang, Le] = lab1est(0.5, 100, z1, z2);
alphas = linspace(10, 150, 10);

errors = zeros(1,length(alphas));
for a = (1:length(alphas))
   total = 0;
   for i = 1:100 %100 here is N 
       z1 = @(t)y1(t)+alphas(a)*randn(1,length(t));
       z2 = @(t)y2(t)+alphas(a)*randn(1,length(t));
       [angles, Ls] = lab1est(0.5, 100, z1, z2);
       total = total + (Ls-100)^2; %the 100 here is L
   end
   errors(a) = total/100; %100 here is N
end
figure('Name', "2.4 b")
plot(alphas, errors)
title('Average Squared Error');
xlabel('alpha');
ylabel('Average squared error');

%% 2.1 D

function [y1, y2] = lab1sim(A,B,L,sig)
    y1 = @(t)sig(t-calculateDelay(A, B,L)); 
    y2 = @(t)sig(t-calculateDelay(2*A, B,L));
end
%% 2.1 A

function delay = calculateDelay(A, B, L)
    delay = sqrt((B^2)+(L-A)^2)/(333+(1/3));
end
%% 2.3 B

function [angle, L] = lab1est(A,B,y1,y2)
    Fs = 44.1*1000;
    x = 0:1/Fs:0.5;
    y1n = y1(x);
    y2n = y2(x);
    [C, lags] = xcorr(y1n, y2n);
    maxC = max(C);
    lagIndex = find(C == maxC);
    lag = lags(lagIndex)/Fs;
    angle = asin(((333+(1/3))/A)*lag);
    L = B*tan(angle);
end

