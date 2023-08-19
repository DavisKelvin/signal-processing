%%
%fft函数频率计算
ccc;
Fs = 1000; % Sampling frequency
T = 1/Fs; % Sample time
N = 1000; % Length of signal
t = (0:N-1)*T; % Time vector
% Sum of a 50 Hz sinusoid(正弦波) and a 120 Hz sinusoid
x = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
y = x + 2*randn(size(t)); % Sinusoids plus noise
figure;
% plot(Fs*t(1:50),y(1:50))
plot(1000*t,y);
title('Signal Corrupted with Zero-Mean Random Noise') % 零均值随机噪声污染的信号
xlabel('time (milliseconds)') % 毫秒
NFFT = 2^nextpow2(N); % Next power of 2 from length of y
% nextpow2(x)是用来求指数的，这个指数（假定为a）需满足两个条件：
% ①2的a次方大于等于输入值x；
% ②2的（a-1）次方小于输入值x。
Y = abs(fft(y,NFFT))/(NFFT/2);
ff=(0:NFFT-1)*Fs/NFFT;
% Plot single-sided amplitude spectrum.
figure;
plot(ff(1:floor(NFFT/2)),Y(1:floor(NFFT/2)));
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')