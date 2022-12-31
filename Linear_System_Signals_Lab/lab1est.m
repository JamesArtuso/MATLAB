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