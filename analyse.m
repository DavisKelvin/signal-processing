%% �ź�x=0.5*sin(2*pi*15*t)+2*sin(2*pi*40*t)������Ƶ��fs=100Hz���ֱ����N=128��1024���Ƶͼ
clc;
clear all;
close all;
%���źŲ�������Ϊ128��Ĵ��� 
fs=100;
N1=128;    %����Ƶ�ʺ����ݵ��� 
n1=0:N1-1;
t1=n1/fs;    %ʱ������ 
x1=0.5*sin(2*pi*15*t1)+2*sin(2*pi*40*t1); %�ź� 
y1=fft(x1,N1)/(N1/2);     %���źŽ��п���Fourier�任 
mag1=abs(y1);      %���Fourier�任������ 
f1=n1*fs/N1;     %Ƶ������ 
figure
subplot(2,2,1)
plot(f1,mag1);    %�����Ƶ�ʱ仯����� 
% �����ֱ�f=(-N1/2:N1/2)*fs/N1; plot(f,fftshift(abs(fft(x1)))/(N1/2))���������ں���Ƶ���ǹ���x=0�ԳƵ�
xlabel('Ƶ��/Hz'); 
ylabel('���');
title('N1=128');
grid on; 
subplot(2,2,2)
plot(f1(1:N1/2),mag1(1:N1/2)); %����۵�Ƶ��֮ǰ��Ƶ�ʱ仯�����;
% fs=100Hz���۵�Ƶ��Ϊfs/2=50Hz������Ƶ��ͼ�����۵�Ƶ��Ϊ�Գ���ģ��ɴ˿���֪��FFT�任���ݵĶԳ��ԣ�
% �����FFT���ź����׷�����ֻ�迼��0~�۵�Ƶ�ʷ�Χ�ڵķ�Ƶ���ԣ�
% ���⣬����Ĵ�С�����ò��������йأ�����128���1024�����ͬƵ�ʵ�������в�ͬ�ı���ֵ��
% ����ͬһ��ͼ�У�40Hz��15Hz�񶯷�ֵ֮�Ⱦ�Ϊ4��1������ʵ���0.5��2��һ�µģ�Ϊ������ʵ�����Ӧ����Ҫ���任��������2����N��
xlabel('Ƶ��/Hz'); 
ylabel('���');
title('N1=128(����)');
grid on; 

%���źŲ�������Ϊ1024��Ĵ��� 
fs=100;
N2=1024;
n2=0:N2-1;
t2=n2/fs; 
x2=0.5*sin(2*pi*15*t2)+2*sin(2*pi*40*t2); %�ź� 
y2=fft(x2,N2)/(N2/2);    %���źŽ��п���Fourier�任 
mag2=abs(y2);    %��ȡFourier�任����� 
f2=n2*fs/N2; 
subplot(2,2,3)
plot(f2,mag2); %�����Ƶ�ʱ仯����� 
xlabel('Ƶ��/Hz'); 
ylabel('���');
title('N2=1024');
grid on; 
subplot(2,2,4) 
plot(f2(1:N2/2),mag2(1:N2/2)); %����۵�Ƶ��֮ǰ��Ƶ�ʱ仯����� 
xlabel('Ƶ��/Hz'); 
ylabel('���');
title('N2=1024(����)');
grid on; 

%% �Գ�Ƶ����
figure
subplot(2,1,1)
ff1=(-N1/2:N1/2-1)*fs/N1; 
plot(ff1,fftshift(abs(fft(x1)))/(N1/2));  %���źŲ�������Ϊ128��Ĵ��� 
xlabel('Ƶ��/Hz'); 
ylabel('���');
title('N1=128');
grid on; 

subplot(2,1,2)
ff2=(-N2/2:N2/2-1)*fs/N2; 
plot(ff2,fftshift(abs(fft(x2)))/(N2/2));   %���źŲ�������Ϊ1024��Ĵ��� 
xlabel('Ƶ��/Hz'); 
ylabel('���');
title('N1=1024');
grid on; 

%% �����plot(f(1:N/2),mag(1:N/2))���ַ������ƣ�ϣ�����ر任Ҳʵ����˫���׵������׵�ת��������������ȼӱ�
figure
plot(f2,abs(fft(hilbert(x2),N2))/(N2/2)/2); 
xlabel('Ƶ��/Hz'); 
ylabel('���');
title('N=1024(����)');
grid on; 

%% ʵ���ϣ���fft�������ź����г��Ȳ�ͬʱ��
ts=0:1/fs:1-1/fs; %ʱ������
x3=0.5*sin(2*pi*15*ts)+2*sin(2*pi*40*ts); %�ź�
%��128���fft����
Nfft1=128;
f3=(0:1/Nfft1:1-1/Nfft1)*fs;    %Ƶ������ 
y3=fft(x3,Nfft1)/(Nfft1/2);
mag3=abs(y3); 
figure
subplot(2,2,1)
plot(f3,mag3);
xlabel('Ƶ��/Hz'); 
ylabel('���');
title('Nfft1=128');
grid on; 
subplot(2,2,2)
plot(f3(1:Nfft1/2),mag3(1:Nfft1/2)); %����۵�Ƶ��֮ǰ��Ƶ�ʱ仯�����;
xlabel('Ƶ��/Hz'); 
ylabel('���');
title('Nfft1=128(����)');
grid on; 

%��1024���fft����
Nfft2=1024;
f4=(0:1/Nfft2:1-1/Nfft2)*fs;    %Ƶ������ 
y4=fft(x3,Nfft2)/(Nfft2/2);
mag4=abs(y4); 
subplot(2,2,3)
plot(f4,mag4);
xlabel('Ƶ��/Hz'); 
ylabel('���');
title('Nfft2=1024');
grid on; 
subplot(2,2,4)
plot(f4(1:Nfft2/2),mag4(1:Nfft2/2)); %����۵�Ƶ��֮ǰ��Ƶ�ʱ仯�����;
xlabel('Ƶ��/Hz'); 
ylabel('���');
title('Nfft2=1024(����)');
grid on; 






