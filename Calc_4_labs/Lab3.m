%% Setup
%James Artuso
%Lab 3
syms O(t) m K;
nums = [0,1,6,9];
rng('default');
randoms = randomizeOrder(nums);
colors = 'rbgy';

%% 1.1 Distinguishing different types of damping
dO = diff(O,t);
cond = [O(0)==1 , dO(0) == 5];

for i = 1:4
    L = diff(O,t,2)+m*diff(O,t)+9*O == 0;
    L = subs(L, m, randoms(i));
    Lsolve(t) = dsolve(L, cond);
    sols(i) = Lsolve;
end

for i = 1:4
   X = linspace(0,10, 100);
   plotGraph = subs(sols(i),t,X);
   figures(i) = figure;
   hold on
   grid on
   axis([0 10 -2 2]);
   currCol = colors(i);
   plot(X,plotGraph, colors(i));
   hold off
end

%% 1.2 Rename Graphs

%Visually, it is easy to pick out which solutions are undamped and
%underdamped. This is because they display periodic behavior. The
%underdamped system will tend towards zero, while the undamped will not.
%The underdamped system will have a mu value of 1
%The undapmed system will have a mu value of 0.

%Disinguishing between the critically damped and overdamped system is more
%difficult to do graphically. You could see which
%goes to zero faster as the crtically damped
%function will approach zero faster. This however is less
%reliable. Rather, it is much easier to distinguish them
%from their solutions. The critically damped solution should be of the
%form c_1e^(at)+c_2te^(bt). In contrast, the overdamped system will be of
%the form c_1e^(at)+c_2e^(bt). 
%The critically damped system will have a mu value of 6.
%The overdamped system will have a mu value of 9.


solm0 = sols(3); %This is my undamped solution
gr1m0 = figures(3);

solm1 = sols(4); %This is my underdamped solution
gr1m1 = figures(4);

solm9 = sols(1); %This is my overdamped solution
gr1m9 = figures(1);

solm6 = sols(2); %This is my critically damped solution
gr1m6 = figures(2);

%% 1.3 Underdamping
figure('Name', "Underdamped and Undamped");
hold on
grid on
 X = linspace(0,10, 1000);
 undampedGraph = subs(solm0,t,X);
 underdampedGraph = subs(solm1,t,X);
 plot(X,undampedGraph,'g');
 plot(X,underdampedGraph,'y');
hold off

%The two functions are very similar. For example, when these two functions
%begin at theta = 0, they both begin at the same point. However, it becomes
%apparent quick quickly, that the undamped system is increasing at a
%greater rate than the underdamped system. This makes sense due to the
%dampening. Another similarity is the t value of the critical points. Both
%graphs have critical points that occure at periodic intervals, however
%these intervals are not equal. In addition, the undamped system have
%critical points at the same y value, while the underdamped system has the
%critical points approach zero as t increases. Theta = 0 also occures at
%the same intervals as the critical points. So, they both have theta = 0
%periodically, but at different intervals.


%% 1.4 Overdamping
figure('Name', "Overdamped and Critically damped");
hold on
grid on
 X = linspace(0,10, 1000);
 criticallyGraph = subs(solm6,t,X);
 overdampedGraph = subs(solm9,t,X);
 plot(X,criticallyGraph,'b');
 plot(X,overdampedGraph,'r');
hold off

%Both systems display similar features. They both have a hump at the
%beginning which turns into an exponential function approaching zero. Both
%systems will never have theta equal to zero since they only have
%exponential terms. It is also important to notice that the critically
%damped system seems to approach zero faster than the overdamped system. In
%addition, both graphs have a single critical point. The critically damped
%system has a greater critical point which occures at a later t than the
%critical point of the overdamped system.



%% 1.5 Overshoot
cond = [O(0)==1 , dO(0) == -8];
L = diff(O,t,2)+8*diff(O,t)+9*O == 0;
Lsolve(t) = dsolve(L, cond);
OverShootSol = Lsolve;
plotGraph = subs(OverShootSol,t,X);
figure
hold on
grid on
axis([0 10 -2 2]);
plot(X,plotGraph);
hold off
%My value of theta prime to get an overshoot of about .1 radians is -8

%% 2 Setup
for i = 1:4
   [x,y] = ode45(@(t,y) G(t,y,randoms(i),9),[0 10],[1 5]); 
   figures2(i) = figure;
   hold on
   grid on
   plot(x,y(:,1), colors(i));
   hold off
end

%% 2.1 Undamped motion
figure('Name','Undamped Comparison');
hold on
grid on
[x,y] = ode45(@(t,y) G(t,y,0,9),[0 10],[1 5]);
plot(x,y(:,1),'r');
plot(X,undampedGraph,'b');
hold off
%While inspecting the linear case of this function, the solution returns to
%theta = 0 on regular intervales. In the nonlinear case, this also appears
%to be true. However, the period for both are very different. The amplitude
%is also different, as the nonlinear case has a greater max and a lower
%min.



%% 2.2 Underdamped motion
figure('Name','Underdamped Comparison');
hold on
grid on
[x,y] = ode45(@(t,y) G(t,y,1,9),[0 10],[1 5]);
plot(x,y(:,1),'r');
plot(X,underdampedGraph,'b');
hold off
%In the nonlinear case for a critically damped system, the maximum value
%occurs at a later t with a greater magnitude. However, every critical
%point for the nonlinar case after that is closer to zero than its linear
%counterpart. In addition, the distance between corresponding linear and
%nonlinear critical points seems to get greater as t increases.


%% 2.3 Critically Damped motion
figure('Name','Critically Damped Comparison');
hold on
grid on
[x,y] = ode45(@(t,y) G(t,y,6,9),[0 10],[1 5]);
plot(x,y(:,1),'r');
plot(X,criticallyGraph,'b');
hold off
%Both graphs feature similar trends. Both have a single critical point and
%then tend towards zero as t increases. The critical point for the
%nonlinear however occurs at a later t with a greater magnitude. In
%addition, it tends towards zero slower than the linear graph.



%% 2.4 Overdamped motion
figure('Name','Overdamped Comparison');
hold on
grid on
[x,y] = ode45(@(t,y) G(t,y,9,9),[0 10],[1 5]);
plot(x,y(:,1),'r');
plot(X,overdampedGraph,'b');
hold off
%This graph displays many of the characteristics of the prervious part.
%Both have a single critical point, and tend towards zero. In addition, the
%nonlinear case seems to tend towards zero slower than the linear case.

%% 3 Distinguishing different types of damping
dO = diff(O,t);
cond = [O(0)== 0 , dO(0) == 0];
W = [40, 4, 2.915, 0.4];
w = sym('w');


for i = 1:4
    for j = 1:4
        F = diff(O,t,2)+m*diff(O,t)+9*O == cos(W(i)*t);
        F = subs(F, m, randoms(j));
        Fsolve = dsolve(F, cond);
        Fsols(i,j) = Fsolve;
    end
end

for i = 1:4
    figure('Name', strcat("w =", string(W(i))));
    texttile = tiledlayout(2,2);
    for j = 1:4
        nexttile
        X = linspace(0,10, 1000);
        plotGraph = subs(Fsols(i,j),t,X);
        grid on
        xlim([0 10]);
        plot(X,plotGraph, colors(j));
    end
end
%Mus are the same color as they have been the whole lab

%The steady state frequency of this system depends on the value of omega.
%Specifically, the steady state frequency is equal to omega/2pi. The
%natural frequncy can be found by seeing which omega increases the
%amplitude of solution when mu is equal to zero. From testing, we can see
%that omega = 2.915 is the closest to this frequency. This makes sense since
%from the homogenous undamped ODE, we know that the fundamental frequency
%is equal to 3.
%As omega changes, the solution changes greatly. 
%If omega is large, the frequenc is very high, so the graph returns to zero 
%a lot. If
%omega is smaller, there are much less oscillations. In the over and
%critically damped cases, the solution will tend towards the steady state
%solution. In the underdamped and undamped solutions, the curve looks like
%waves in waves. When omega is large, this is very apparent. When it is
%smaller, it is much more subtle.

function returnMat = randomizeOrder(h)
    returnMat = zeros(1,4);
    for i = 1:4
       num = randi([1, length(h)]);
       returnMat(i) = h(num);
       h(num) = [];
    end
  
end

function dydt = G(t,y,m,K)
    dydt = zeros(2,1);
    dydt(1) = y(2);
    dydt(2) = -m*y(2)-K*sin(y(1));
end
