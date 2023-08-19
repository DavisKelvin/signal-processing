%% FFT频谱的画法(对称、单边)
ccc;
fs=10000;   %采样率
t=-0.1:1/fs:0.1;   %时域坐标
f1=300;
f2=2000;
f3=3000;
x1=cos(2*pi*f1*t);   
x2=2*sin(2*pi*f2*t);   
x3=4*sin(2*pi*f3*t);   
x=x1;
N=length(x);

%常规画法
ff=(0:N-1)*fs/N;
yy=abs(fft(x))/(N/2);
figure;
subplot(2,2,1)
plot(ff,yy);
xlabel('频率/Hz');
ylabel('振幅');
title('常规画法');
grid on;

%以x=0为轴对称画法
f=(-N/2:N/2-1)*fs/N;
y=fftshift(abs(fft(x)))/(N/2);
subplot(2,2,2)
plot(f,y);
xlabel('频率/Hz');
ylabel('振幅');
title('以x=0为轴对称画法');
grid on;

%单边画法
%绘出折叠频率之前,(0~fs/2)范围内的频谱
subplot(2,2,3)
plot(ff(1:floor(N/2)),yy(1:floor(N/2)));
xlabel('频率/Hz');
ylabel('振幅');
title('(0~fs/2)范围内的单边频谱');
grid on;

%单边画法
%hilbert(),希尔伯特变换也实现了双边谱到单边谱的转化，但会引起幅度加倍,故要除以2
subplot(2,2,4)
plot(ff,abs(fft(hilbert(x),N))/(N/2)/2);
xlabel('频率/Hz');
ylabel('振幅');
title('希尔伯特变换实现单边频谱');
grid on;
sgtitle('FFT频谱的画法(对称、单边)','color','black','Fontsize',20) %给子图加总标题
