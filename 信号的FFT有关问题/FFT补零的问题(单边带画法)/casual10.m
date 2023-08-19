%% FFT补零的问题 (单边带画法，频谱范围0~fs/2)
ccc;
% 序列32点，32点FFT 
fs=100;
n1=32;
t1=(0:n1-1)/fs;
x1=0.5*sin(2*pi*15*t1)+2*sin(2*pi*40*t1);
N1=32;
f1=(0:N1-1)*fs/N1;
y1=abs(fft(x1,N1))/(N1/2);
figure;
plot(f1(1:N1/2),y1(1:N1/2));
xlabel('频率/Hz');
ylabel('振幅');
title('ndata=32, Nfft=32');   %  频率分辨率很低
grid on;

% 时间序列不变，只增加FFT点数(128点)
% 序列32点，128点FFT 
N2=128;
f2=(0:N2-1)*fs/N2;
y2=abs(fft(x1,N2))/(N2/2);
figure;
plot(f2(1:N2/2),y2(1:N2/2));
xlabel('频率/Hz');
ylabel('振幅');
title('ndata=32, Nfft=128(只增加fft点数)');  % 只会带来锯齿，不会改变频率分辨率
grid on;

% 时间序列末尾手动补零(补成128点序列)，再增加FFT点数(128点)
% 序列128点，128点FFT 
t11=[t1,zeros(1,N2-length(t1))];
x11=0.5*sin(2*pi*15*t11)+2*sin(2*pi*40*t11);
y22=abs(fft(x11,N2))/(N2/2);
figure;
plot(f2(1:N2/2),y22(1:N2/2));
xlabel('频率/Hz');
ylabel('振幅');
title('ndata=128(时间序列末尾补零), Nfft=128(同时增加fft点数)');  % 与上图毫无变化
grid on;

% 序列136点，128点FFT 
n2=136;
t2=(0:n2-1)/fs;
x2=0.5*sin(2*pi*15*t2)+2*sin(2*pi*40*t2);
y3=abs(fft(x2,N2))/(N2/2);
figure;
plot(f2(1:N2/2),y3(1:N2/2));
xlabel('频率/Hz');
ylabel('振幅');
title('ndata=136(增加有效时间序列长度), Nfft=128');  %  提高了频率分辨率，消除锯齿
grid on;

% 序列136点，256点FFT 
N3=256;
f3=(0:N3-1)*fs/N3;
y4=abs(fft(x2,N3))/(N3/2);
figure;
plot(f3(1:N3/2),y4(1:N3/2));
xlabel('频率/Hz');
ylabel('振幅');
title('ndata=136, Nfft=256'); %  不改变频率分辨率，又带来锯齿
grid on;



