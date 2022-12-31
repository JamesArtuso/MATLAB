format longG %This is how you can make Matlab print all the digits
a=2^300*300^2;
disp(sprintf('\n2^300*300^2 =%100.f \n\n',a))

%2 Arithmetic
%2.1 
two1 = (2^300)* (300^2)
two2 = 4/7
two2 = two2 * 700
two3 = ((sqrt(2)-1)^5)
two32 = sqrt(sym(2))
two322 = expand((two32 - 1)^5)
digits(30);
p=sym(pi);
r163=sqrt(sym(163));
value=vpa(exp(p*r163));
disp(sprintf('\n%s \n\n',value))

%3 Algebra
format short
syms x
foiledExpression = factor((x^4)-3*(x^2)+1,x,'Factormode', 'complex')

syms y

subs((x^4)*y+x*(y^2),x,1)
subs((x^4)*y+x*(y^2),y,x)
subs(subs((x^4)*y+x*(y^2),x,2),y,3)