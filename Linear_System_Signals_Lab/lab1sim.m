function [y1, y2] = lab1sim(A,B,L,sig)
    y1 = @(t)sig(t-calculateDelay(A, B,L)); 
    y2 = @(t)sig(t-calculateDelay(2*A, B,L));
end