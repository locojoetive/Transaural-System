gRR = audioread("RR");
gRL = audioread("RL");
gLR = audioread("LR");
gLL = audioread("LL");

legend(gRR,.., gll);
subPlot();
plot(gRR)
xLabel("x-axis");
yLabel("y-axis");
maag2dB();
title("")

S1_l = ft(s1_l, lf);
S1_r = ft(s1_r, lf);
S2_l = ft(s2_l, lf);
S2_r = ft(s2_l, lf);

denomiator = S1_l * S1_r - S2_l * S2_r;
denominator = denominator + sign(denominator) * max(abs(denominator)) * ...
    
H1_l = S2_r./denominator;
H1_r = -S1_r./denominator;
H2_l = -S2_r./denominator;
H2_r = S1_l./denominator;

Sl = audioread("....");