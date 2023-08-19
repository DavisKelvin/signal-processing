%% 信号x=0.5*sin(2*pi*15*t)+2*sin(2*pi*40*t)。采样频率fs=100Hz，分别绘制N=128、1024点幅频图
clc;
clear all;
close all;
%对信号采样数据为128点的处理 
fs=100;
N1=128;    %采样频率和数据点数 
n1=0:N1-1;
t1=n1/fs;    %时间序列 
x1=0.5*sin(2*pi*15*t1)+2*sin(2*pi*40*t1); %信号 
y1=fft(x1,N1)/(N1/2);     %对信号进行快速Fourier变换 
mag1=abs(y1);      %求得Fourier变换后的振幅 
f1=n1*fs/N1;     %频率序列 
figure
subplot(2,2,1)
plot(f1,mag1);    %绘出随频率变化的振幅 
% 和这种表达：f=(-N1/2:N1/2)*fs/N1; plot(f,fftshift(abs(fft(x1)))/(N1/2))的区别在于后者频谱是关于x=0对称的
xlabel('频率/Hz'); 
ylabel('振幅');
title('N1=128');
grid on; 
subplot(2,2,2)
plot(f1(1:N1/2),mag1(1:N1/2)); %绘出折叠频率之前随频率变化的振幅;
% fs=100Hz，折叠频率为fs/2=50Hz。整个频谱图是以折叠频率为对称轴的，由此可以知道FFT变换数据的对称性，
% 因此用FFT对信号做谱分析，只需考察0~折叠频率范围内的幅频特性，
% 另外，振幅的大小与所用采样点数有关，采用128点和1024点的相同频率的振幅是有不同的表现值，
% 但在同一幅图中，40Hz与15Hz振动幅值之比均为4：1，与真实振幅0.5：2是一致的，为了与真实振幅对应，需要将变换后结果乘以2除以N。
xlabel('频率/Hz'); 
ylabel('振幅');
title('N1=128(单边)');
grid on; 

%对信号采样数据为1024点的处理 
fs=100;
N2=1024;
n2=0:N2-1;
t2=n2/fs; 
x2=0.5*sin(2*pi*15*t2)+2*sin(2*pi*40*t2); %信号 
y2=fft(x2,N2)/(N2/2);    %对信号进行快速Fourier变换 
mag2=abs(y2);    %求取Fourier变换的振幅 
f2=n2*fs/N2; 
subplot(2,2,3)
plot(f2,mag2); %绘出随频率变化的振幅 
xlabel('频率/Hz'); 
ylabel('振幅');
title('N2=1024');
grid on; 
subplot(2,2,4) 
plot(f2(1:N2/2),mag2(1:N2/2)); %绘出折叠频率之前随频率变化的振幅 
xlabel('频率/Hz'); 
ylabel('振幅');
title('N2=1024(单边)');
grid on; 

%% 对称频率轴
figure
subplot(2,1,1)
ff1=(-N1/2:N1/2-1)*fs/N1; 
plot(ff1,fftshift(abs(fft(x1)))/(N1/2));  %对信号采样数据为128点的处理 
xlabel('频率/Hz'); 
ylabel('振幅');
title('N1=128');
grid on; 

subplot(2,1,2)
ff2=(-N2/2:N2/2-1)*fs/N2; 
plot(ff2,fftshift(abs(fft(x2)))/(N2/2));   %对信号采样数据为1024点的处理 
xlabel('频率/Hz'); 
ylabel('振幅');
title('N1=1024');
grid on; 

%% 与采用plot(f(1:N/2),mag(1:N/2))这种方法类似，希尔伯特变换也实现了双边谱到单边谱的转化，但会引起幅度加倍
figure
plot(f2,abs(fft(hilbert(x2),N2))/(N2/2)/2); 
xlabel('频率/Hz'); 
ylabel('振幅');
title('N=1024(单边)');
grid on; 

%% 实际上，做fft点数和信号序列长度不同时：
ts=0:1/fs:1-1/fs; %时间序列
x3=0.5*sin(2*pi*15*ts)+2*sin(2*pi*40*ts); %信号
%做128点的fft处理
Nfft1=128;
f3=(0:1/Nfft1:1-1/Nfft1)*fs;    %频率序列 
y3=fft(x3,Nfft1)/(Nfft1/2);
mag3=abs(y3); 
figure
subplot(2,2,1)
plot(f3,mag3);
xlabel('频率/Hz'); 
ylabel('振幅');
title('Nfft1=128');
grid on; 
subplot(2,2,2)
plot(f3(1:Nfft1/2),mag3(1:Nfft1/2)); %绘出折叠频率之前随频率变化的振幅;
xlabel('频率/Hz'); 
ylabel('振幅');
title('Nfft1=128(单边)');
grid on; 

%做1024点的fft处理
Nfft2=1024;
f4=(0:1/Nfft2:1-1/Nfft2)*fs;    %频率序列 
y4=fft(x3,Nfft2)/(Nfft2/2);
mag4=abs(y4); 
subplot(2,2,3)
plot(f4,mag4);
xlabel('频率/Hz'); 
ylabel('振幅');
title('Nfft2=1024');
grid on; 
subplot(2,2,4)
plot(f4(1:Nfft2/2),mag4(1:Nfft2/2)); %绘出折叠频率之前随频率变化的振幅;
xlabel('频率/Hz'); 
ylabel('振幅');
title('Nfft2=1024(单边)');
grid on; 






