clear all
format compact
clc

[gRR, fs]= audioread("headphones+spkr/R0e010a.wav");

dt = 1/fs;
t = 0:dt:(length(gRR)*dt)-dt;

subplot(2, 2, 1);
plot(t,gRR);
xlabel('Seconds');
ylabel('Amplitude');
title("R0e010a.WAV");

[gRL, fs] = audioread("headphones+spkr/R0e350a.wav");

subplot(2, 2, 2);
plot(t,gRL);
xlabel('Seconds');
ylabel('Amplitude');
title("R0e350a.WAV");

[gLR, fs] = audioread("headphones+spkr/L0e010a.wav");

subplot(2, 2, 3);
plot(t,gLR);
xlabel('Seconds');
ylabel('Amplitude');
title("L0e010a.WAV");

[gLL, fs] = audioread("headphones+spkr/L0e350a.wav");

subplot(2, 2, 4);
plot(t,gRL);
xlabel('Seconds');
ylabel('Amplitude');
title("L0e350a.WAV");

figure

fftGRR = fft(gRR, 1725632);
subplot(2, 2, 1);
plot(abs(fftGRR));
xlabel('Frequency');
ylabel('Intensity');
title("GRR FFT");

fftGRL = fft(gRL, 1725632);
subplot(2, 2, 2);
plot(abs(fftGRL));
xlabel('Frequency');
ylabel('Intensity');
title("GRL FFT");

fftGLR = fft(gLR, 1725632);
subplot(2, 2, 3);
plot(abs(fftGLR));
xlabel('Frequency');
ylabel('Intensity');
title("GLR FFT");

fftGLL = fft(gLL, 1725632);
subplot(2, 2, 4);
plot(abs(fftGLL));
xlabel('Frequency');
ylabel('Intensity');
title("GLL FFT");

denominator = (fftGRR .* fftGLL - fftGRL .* fftGLR);

%Filter
%denominator(abs(denominator) <= 0.1) = 0.1 + 0.1i;

hRR = fftGLL ./ denominator;
hRL = fftGLR ./ -denominator;
hLR = fftGRL ./ -denominator;
hLL = fftGRR ./ denominator;

figure

sL = audioread("headphones+spkr/ZOOM0005_Tr1.wav");
sR = audioread("headphones+spkr/ZOOM0005_Tr3.wav");

xR = hRR .* sR + hLR .* sL;
xL = hRL .* sR + hLL .* sL;

% yR = xL .* gLL + xR .* gRL;
% yL = xR .* gRR + xR .* gLR;
xl = ifft(xL, length(sL), 'symmetric');
xr = ifft(xR, length(sL), 'symmetric');

audio = [xl xr];
audiowrite("output.wav", audio, fs);

subplot(2, 1, 1);
plot(xr);
subplot(2, 1, 2);
plot(xl);
%subplot(2, 2, 3);
%plot(yR);
%subplot(2, 2, 4);
%plot(yL);
figure