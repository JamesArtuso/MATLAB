% This script is meant to help solve problems where the steps for
% binary arithmetic need to be shown

%James Artuso

syms n
%Pa = booth([1,0,1,0], [0,1,1,1,0])
%Pa = booth([1,1,1,0], [0,0,1,0])
%Pa = booth([0,1,1,1,0,0],[1,1,1,0,1,0]);
%Pa = booth([1,0,0,0,1,1,0,1], [0,0,1,0,0,0,1,1])
%Pa2 = multiply([1,0,0,1], [1,0,0,1])
%Pa3 = optimized([1,0,0,1],[1,0,1,0])
%[Ra, Qa] = optimizedD([1,0,0,1,1,1,0,0], [0,0,1,0,0,1,1,1]);
%optimizedD([0,1,1,1], [0,0,1,0])
%[s, e, f] = toFloat(23.724, 5,10);
%floatMultiply(0.001875,-0.045625, 6, 11);
%floatMultiply(.3344770219,23.724, 5, 10)
%toFloat(-15.00000858306884765625);
floatAdd(-3.5000073909759521484375,-15.00000858306884765625)

%floatAdd(-2.5,-2.75);
%floatAdd(3.25, 30, 6, 3);

%toFloat(3.254)
%optimizedD([1,0,1,1,1,1], [0,1,0,0,1,0])
%toFloat(-18);
%floatAdd(-0.011, 0.00875, 4, 6);
%toFloat(-.011+0.00875, 4, 6)

%optimizedD([1,1,0,1,1,0], [0,0,0,0,1,1])

%twosComp([0,0,0,1,0,0,1,0]);

%toFloat(-18)

%53
%-19
%optimizedD([1,1,0,1,0,1],[0,1,0,0,1,1])
%twosComp([0,0,1,1,1,1])
%findSize(4,6)

%toFloat(-0.015,4,7);
%toFloat(0.01075,4,7)
%toFloat(0.00925);
%toFloat(0.00925,5,6);
%floatAdd(-0.015, 0.01075, 4, 7);


%twosComp([0,0,1,1,1,1,0,1,1,0,0,0])

%toFloat(0.002475e-,9,12);
%floatAdd(-0.03625,0.002475,9,12);

%optimized([1,0,0,1,0,1,0,0,0,1,1,1,1,0,0], [1,0,1,0,0,0,1,0,0,0,1,1,0,0,0])
%d2a(binAddition(a2d(-5,9),a2d(-9,9)));
%a2d(241, 9)


%This does the steps for booths algorithm in binary
function steps = booth(m , r)
    steps = ["step", "Product", "ghost bit", "multiplicand"];
    P = zeros(1, length(r));
    A = d2a([m, P]);
    nm = a2d(-1*d2a(m), length(m));
    S = d2a([nm, P]);
    ghost = 0;
    P = [P, r];
    steps(2, 1) = "Initalize";
    steps(2,2) = strjoin(string(P));
    steps(2,3) = "0";
    steps(2,4) = strjoin(string(m));
    curstep = 3;
    for i = [1:length(r)]
       if(P(end) == 0 && ghost == 1)
            Pd = d2a(P);
            Pd = Pd+A;
            P = a2d(Pd, length(P));
            steps(curstep, 1) = "add";
            steps(curstep, 2) = strjoin(string(P));
            steps(curstep, 3) = "1";
            steps(curstep, 4) = strjoin(string(m));
            curstep = curstep+1;
       end
       if(P(end) == 1 && ghost == 0)
           Pd = d2a(P);
           Pd = Pd+S;
           P = a2d(Pd, length(P));
           steps(curstep, 1) = "sub";
           steps(curstep, 2) = strjoin(string(P));
           steps(curstep, 3) = "0";
           steps(curstep, 4) = strjoin(string(nm));
           curstep = curstep+1;
       end
       ghost = P(end);
       P(2:end) = P(1:end-1);
       P(1) = P(2);
       steps(curstep, 1) = "shift";
       steps(curstep, 2) = strjoin(string(P));
       steps(curstep, 3) = string(ghost);
       steps(curstep, 4) = steps(curstep-1,4);
       curstep = curstep+1;
    end
    
end


%This function does a simple multiplication algorithm
function steps = multiply(multiplier, multiplicand)
     steps = ["step", "Multiplier", "Multiplicand", "Product"];
     multiplicand = [zeros(1, length(multiplicand)),multiplicand];
     P = zeros(1, length(multiplicand));
     steps(2,1) = "Initalize";
     steps(2,2) = strjoin(string(multiplier));
     steps(2,3) = strjoin(string(multiplicand));
     steps(2,4) = strjoin(string(P));
     curstep = 3;
     for i = [1:length(multiplier)]
         if(multiplier(end) == 1)
            Md = d2a(multiplicand);
            Pd = d2a(P);
            Pd = Pd+Md;
            P = a2d(Pd, length(P));
            steps(curstep,1) = "add";
            steps(curstep,2) = strjoin(string(multiplier));
            steps(curstep,3) = strjoin(string(multiplicand));
            steps(curstep,4) = strjoin(string(P));
            curstep = curstep+1;
         end
     multiplier(2:end) = multiplier(1:end-1);
     multiplier(1) = 0;
     multiplicand(1:end-1) = multiplicand(2:end);
     multiplicand(end) = 0;
     steps(curstep,1) = "shift";
     steps(curstep,2) = strjoin(string(multiplier));
     steps(curstep,3) = strjoin(string(multiplicand));
     steps(curstep,4) = strjoin(string(P));
     curstep = curstep+1;
     end
end


%This function does an optimized multiplication algorithm
function steps = optimized(multiplier, multiplicand)
   Md = d2a([0,multiplicand,zeros(1, length(multiplicand))]); 
   P = [zeros(1, length(multiplier)+1), multiplier];
   steps = ["Step", "Multiplicand", "Product"];
   steps(2, 1) = "Initalize";
   steps(2, 2) = strjoin(string(multiplicand));
   steps(2, 3) = strjoin(string(P));
   curstep = 3;
   for i = [1:length(multiplier)]
        if(P(end) == 1)
           Pd = d2a(P);
           Pd = Pd+Md;
           P = a2d(Pd, length(P));
           steps(curstep, 1) = "Add";
           steps(curstep, 2) = steps(curstep-1,2);
           steps(curstep, 3) = strjoin(string(P));
           curstep = curstep+1;
        end
        P(2:end) = P(1:end-1);
        P(1) = 0;
        steps(curstep, 1) = "Shift";
        steps(curstep, 2) = steps(curstep-1,2);
        steps(curstep, 3) = strjoin(string(P));
        curstep = curstep+1;
   end
   steps(curstep, 2) = strjoin(["Carry = ", string(P(1))]);
   P = P(2:end);
   steps(curstep, 1) = "Solution";
   steps(curstep, 3) = strjoin([" ",string(P)]);
end

%This function does the steps for optimized division
function steps = optimizedD(dividend, divisor) %MAKE SURE PARAMS ARE SAME LEN
    steps = ["Step", "Divisor", "Dividend"];
    
    rem = [zeros(1, length(dividend)), dividend];
    steps(2,1) = "Initalize";
    steps(2,2) = strjoin(string(divisor));
    steps(2,3) = strjoin(string(rem));
    
    dd = d2a([divisor,zeros(1, length(divisor))]); 
    rem(1:end-1) = rem(2:end);
    rem(end) = 0
    
    steps(3,1) = "Shift left 1";
    steps(3,2) = strjoin(string(divisor));
    steps(3,3) = strjoin(string(rem));
    curstep = 4;
    
    for i = [1:length(divisor)]
        remd = d2a(rem);
        remd = remd-dd;
        rem = a2d(remd, length(rem))
        
        steps(curstep,1) = "Rem = Rem - Div";
        steps(curstep,2) = steps(2,2);
        steps(curstep,3) = strjoin(string(rem));
        curstep = curstep+1;
        
        if(d2a(rem(1:(length(rem)/2))) < 0)
            remd = d2a(rem);
            remd = remd+dd;
            rem = a2d(remd, length(rem))
            steps(curstep,1) = "Rem = Rem + Div";
            steps(curstep,2) = steps(2,2);
            steps(curstep,3) = strjoin(string(rem));
            curstep = curstep+1;
            
            rem(1:end-1) = rem(2:end);
            rem(end) = 0
            steps(curstep,1) = "Sll Rem, R0 = 0";
            steps(curstep,2) = steps(2,2);
            steps(curstep,3) = strjoin(string(rem));
            curstep = curstep+1;
        else
            rem(1:end-1) = rem(2:end);
            rem(end) = 1 
            steps(curstep,1) = "Sll Rem, R0 = 1";
            steps(curstep,2) = steps(2,2);
            steps(curstep,3) = strjoin(string(rem));
            curstep = curstep+1;
        end
    end
    %Q = rem((end-(length(rem)/2)+1):end);
    %R = rem(1:(length(rem)/2));
    steps(curstep,1) = "Solution";
    steps(curstep,2) = strjoin(["Rem = ", string([0,rem(1:((length(rem)/2)-1))])]);
    steps(curstep,3) = strjoin(["Quo = ", string(rem((end-(length(rem)/2)+1):end))]);
end


%This finction finds the range of values of a floating point number with
%ebits number of exponent bits and mbits number of mantissa bits
function [bias, max, min] = findSize(ebits, mbits)
    bias = 2^(ebits-1)-1;
    %Largest value is when exponent is all 1's except LSB = 0
    %IE significand is about 2, so it will be 
    max = 2*2^(bias);
    
    %smallest value when exponent is all 0's except LSB = 1
    %m is all zeros, so it is about 1
    min = 2^(-(bias-1));
end

%Converts a decimal number to floating point
function [s, e, m, sticky] = toFloat(num,ne, nm, round)%Round is 1 if true
    if nargin==1, ne = 8; nm = 23; round = 1; end
    if nargin==3, round = 1; end %Assumes rounding
    s = 0;
    origNum = num;
    %FINDING s
    if(num < 0)
        s = 1;
        num = abs(num);
        fprintf("Since %f is positive, s = 0\n", num);
    else
        fprintf("Since %f is positive, s = 0\n", num);
    end
    
    %FINDING EXPONENT
    EXP = 0;
    if(num > 1)
        while(num >= 2)
           num = num/2;
           EXP = EXP+1;
        end
    elseif(num == 1)
        %Do nothing
    else
        while(num < 1)
            num = num*2;
            EXP = EXP-1;
        end
    end
    ebias = 2^(ne-1)-1;
    e = EXP+ebias;
    fprintf("%f/(2^(%d)) = %f\n",origNum, EXP, num);
    fprintf("bias = 2^(%d-1)-1 = %d\n", ne, ebias);
    fprintf("e-%d = %d\ne=%d+%d\ne = %d => ", ebias,EXP, EXP, ebias, e);
    e = a2d(e, ne+1);
    e = e(2:end);
    fprintf("%s", string(e));
    fprintf("\n")
    
    %FINDING MANTISSA
    num = num-1;
    m = zeros(1,nm+round);
    sticky = 1;
    for i = [1:(nm+round)] 
       num = num*2;
       fprintf("%f * 2 = %f    ", (num/2), num)
       if(num >= 1)
           fprintf("1\n")
           num = num-1;
           m(i) = 1;
        else
           fprintf("0\n")
           m(i) = 0;
       end
       if(num == 0)
          sticky = 0;
          break; 
       end
    end
    fprintf("m = ")
    fprintf("%s", string(m));
    fprintf("\n");
    if(round == 1)
        if (m(end) == 1) %ROUND BIT = 1 means +1
            fprintf("Since round bit = 1,\n")
            NM = d2a(m);
            NM = NM + 1;
            m = a2d(NM, nm+1);
            fprintf("%s", string(m));
            fprintf("\n");
        end
        m = m(1:end-1);
    end
    
    
    fprintf("So the number is:\n")
    fprintf("%d", s)
    fprintf("    ")
    fprintf("%s",string(e))
    fprintf("    ")
    fprintf("%s", string(m))
    fprintf("\n\n\n")
end

% Show steps for adding floating point numbers
function [s, e, m] = floatAdd(num1, num2, ne, nm, g, r, s)
    if nargin==2, ne=8; nm = 23; g = 1; r = 1; s = 1; end
    if nargin==4, g = 1; r = 1; s = 1;end
    if(size(num1) == 1)
        [s1, e1, m1, sticky1] = toFloat(num1, ne, nm);
    else
        s1 = num1(1)
        e1 = num1(2:1+ne)
        m1 = num1(1+ne:end)
    end
    if(size(num2) == 1)
        [s2, e2, m2, sticky2] = toFloat(num2, ne, nm);
    else
        s2 = num2(1);
        e2 = num2(2:1+ne);
        m2 = num2(2+ne:end);
    end
    fprintf("%f is ",num1);
    fprintf("%s",string(s1));
    fprintf(" ");
    fprintf("%s", string(e1));
    fprintf(" ");
    fprintf("%s", string(m1));
    fprintf("\n")
    
    fprintf("%f is ",num2);
    fprintf("%s",string(s2));
    fprintf(" ");
    fprintf("%s", string(e2));
    fprintf(" ");
    fprintf("%s", string(m2));
    fprintf("\n")
    
    %DOING THE MATH
    e1n = d2a([0,e1]);
    e2n = d2a([0,e2]);
    diff = e1n - e2n; %GET HOW MANY BITS TO SHIFT
    numSticky = 0;
    %APPEND 1 TO MANTISSA 
    %PUT 0 IN FRONT IN CASE WE NEED TO 2's COMPLIMENT
    %put guard and rounding bit at end
    m1 = [0,0,1,m1,0,0];
    m2 = [0,0,1,m2,0,0];
    fprintf("mantissa of %d is ",num1);
    fprintf("1.")
    fprintf("%s", string(m1(4:end-2)))
    fprintf("\n")
    if(diff < 0)
        fprintf("Need to shift %f, by %d bits\n", num1, -diff)
        e=e2n;
        diff = -diff;
        if(any(m1((end-diff):end) == 1))
           fprintf("Sticky is set to 1\n")
           numSticky = 1 ;
        end
        %shift required amount
        m1(diff+1:end) = m1(1:end-diff);
        m1(1:diff) = zeros(1,length(m1(1:diff)));
        fprintf("%d.",m1(3))
        fprintf("%s",string(m1(4:end)))
        fprintf("\n");
    else
        fprintf("Need to shift %f, by %d bits\n", num2, diff)
        e=e1n;
        if(any(m2((end-diff):end) == 1))
            fprintf("Sticky is set to 1\n")
            numSticky = 1 ;
        end
        %shift required amount
        m2(diff+1:end) = m2(1:end-diff);
        m2(1:diff) = zeros(1,length(m2(1:diff)));
        fprintf("%d.",m2(3))
        fprintf("%s",string(m2(4:end)))
        fprintf("\n");
    end
    
    %DO ACTUAL ADDITION
    if(s1 == 1)
       fprintf("Since %d is negative, We need to take the 2's comp\n",num1)
       m1 = twosComp(m1); 
       fprintf("%s",string(m1(1:3)));
       fprintf(".")
       fprintf("%s",string(m1(4:end)));
       fprintf("\n")
    end
    if(s2 == 1)
       fprintf("Since %d is negative, We need to take the 2's comp\n",num2)
       m2 = twosComp(m2);
       fprintf("%s",string(m2(1:3)));
       fprintf(".")
       fprintf("%s",string(m2(4:end)));
       fprintf("\n")
    end
    
    fprintf("Now calculate the sum\n")
    sum = binAddition(m1, m2);
    fprintf("  ");
    fprintf("%s",string(m1(1:3)));
    fprintf(".")
    fprintf("%s",string(m1(4:end)));
    fprintf("\n")
    fprintf("+ ")
    fprintf("%s",string(m2(1:3)));
    fprintf(".")
    fprintf("%s",string(m2(4:end)));
    fprintf("\n")
    for i = 1:(length(m2)+3)
        fprintf("-") 
    end
    fprintf("\n")
    fprintf("  ")
    fprintf("%s",string(sum(1:3)));
    fprintf(".")
    fprintf("%s",string(sum(4:end)));
    fprintf("\n")
    s = 0;
    if(sum(1) == 1)
        s = 1;
        fprintf("Since the sum is negative, take the 2's comp\n")
        sum = twosComp(sum);
        fprintf("%s",string(sum(1:3)));
        fprintf(".")
        fprintf("%s",string(sum(4:end)));
        fprintf("\n")
    end
    fprintf("Now renormalize the number\n")
    if(sum(2) == 1)
       e = e+1;
       if(sum(end) == 1), numSticky = 1;end
       sum(2:end) = sum(1:end-1);
    elseif(sum(3) ~= 1)
        while(sum(3) ~= 1)
        	e = e-1;
            sum(1:end-1) = sum(2:end);
            sum(end) = 0;
        end
    end
    fprintf("%d",sum(3));
    fprintf(".")
    fprintf("%s",string(sum(4:end)));
    fprintf(" * 2^%d\n",(e-(2^(ne-1)-1)));
    
    %ROUND IS NOT DONE YET
    %sum = round(sum,numSticky);
    m = sum(4:end-2);
    e = a2d(e,ne+1);
    e = e(2:end);
    fprintf("sticky bit: %d\n",numSticky);
    fprintf("Without guard and round bits\n")
    fprintf("%d ", s)
    fprintf("%s", string(e))
    fprintf(" ")
    fprintf("%s", string(m))
    fprintf("\n")
end


% Converts decimal number to binary
function varargout = a2d(x,B)

x = x(:);                           % L x 1 column, L = length(x)

x = mod(x,2^B);                     % positive remainder even if x<0

b = rem(floor(x*2.^(1:B)/2^B),2);   % (L x 1) x (1 x B) = L x B matrix

if nargout==0 | nargout==1,
    varargout{1} = b;
else
    for k=1:nargout
        varargout{k} = b(:,k);
    end
end
end

% Converts binary to decimal number
function x = d2a(b,type)

if nargin==1, type=-1; end

B = size(b,2);             % number of bits

b(:,1) = type*b(:,1);      %  negative sign for 2's complement representation

x = b * 2.^(B-1:-1:0)';

end

% Binary addition
function [Ans, v, c5] = binAddition(a, b)
    if (length(a) ~= length(b))
        error("No");
    end
    c = zeros(1,length(a)+1);
    Ans = zeros(1,length(a));
    for r = length(a):-1:1
        sol = a(r) + b(r) + c(r+1);
        if(sol == 1 | sol == 3)
            Ans(r) = 1;
        end
        if(sol == 2 | sol == 3)
            c(r) = 1;
        end
    end
    cendbin = c(1)==1;
    cend1bin = c(2)==1;
    v = cendbin&~cend1bin | ~cendbin&cend1bin;
    if(v == 1)
       Ans = [c(1),Ans]; 
    end
    c5 = c;
end

% Find negative of a two's compliment number
function [comp] = twosComp(A)
    aSize = length(A);
    comp = -1*A + 1;
    one = [zeros(1, aSize-1),1];
    comp = binAddition(comp, one);
end


