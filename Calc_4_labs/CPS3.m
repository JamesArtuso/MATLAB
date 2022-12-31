z = sym('z');
m = sym('m');
l = sym('l');
w = sym('w');
a_0 = sym('a_0');
a_1 = sym('a_1');
accuracy = 50;
mVal = 0;
lVal = 0;


coeff = sym(zeros(accuracy,1));
coeff(1) = a_0;
coeff(2) = a_1;
for n = 2:accuracy
    coeff(n+1) = coeff(n-1)*(((n-3)*(n-2)+(2+2*m)*(n-2)-(l*(l+1)-m*(m+1)))/((n+1)*(n+2)));
    coeff(n+1) = subs(coeff(n+1),m,mVal);
    coeff(n+1) = subs(coeff(n+1),l,lVal);
    coeff(n+1) = simplify(coeff(n+1));
end
sol1 = coeff(1);
sol2 = coeff(2)*z;


for n = 2:accuracy
    if(mod(n,2) == 0)
        sol1 = sol1 + coeff(n+1)*(z^(n));
    else
        sol2 = sol2 + coeff(n+1)*(z^(n));
    end
end

sol1 = sol1*(((1-z^2)^(m/2)));
x1 = linspace(-1,1,50);
sol1 = subs(sol1,m,mVal);
sol1 = subs(sol1,a_0,1)
y1 = subs(sol1,z,x1);


sol2 = sol2*(((1-z^2)^(m/2)));
sol2 = subs(sol2,m,mVal);
sol2 = subs(sol2,a_1,1)
y2 = subs(sol2,z,x1);








k = sym('k');
x = sym('x');
kVal = 1;

coeff = sym(zeros(accuracy,1));
coeff(1) = a_0;
coeff(2) = a_1;
for n = 2:accuracy
    coeff(n+1) = -1*coeff(n-1)*(2*k-1-2*n+3)/(n^2-n);
    coeff(n+1) = subs(coeff(n+1),k,kVal);
    coeff(n+1) = simplify(coeff(n+1));
end
sol1 = coeff(1);
sol2 = coeff(2)*x;


for n = 2:accuracy
    if(mod(n,2) == 0)
        sol1 = sol1 + coeff(n+1)*(x^(n));
    else
        sol2 = sol2 + coeff(n+1)*(x^(n));
    end
end


Vsol1 = sol1*(exp(-(x^2)/2));
x1 = linspace(-8,8,400);
Vsol1 = subs(Vsol1,a_0,1);
y1 = subs(Vsol1,x,x1);


Vsol2 = sol2*(exp(-(x^2)/2));
Vsol2 = subs(Vsol2,a_1,1);
y2 = subs(Vsol2,x,x1);


figure('Name',"a_0, k=4");
hold on
axis([-8 8 -8 8])
plot(x1,y1)
hold off
figure('Name', "a_1,k=4");
hold on
axis([-8 8 -8 8])
plot(x1,y2)
hold off

function dwdt = W(z,w,m,l)
    dwdt = zeros(2,1);
    dwdt(1) = w(2)
    dwdt(2) = asd;
end