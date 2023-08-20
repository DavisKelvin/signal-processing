%% ���޳���������ͬ������FFT�ıȽ� (Ƶ��x=0�Գƻ���)
ccc;
% ����16�㣬16��FFT 
T=0.5;
N1=16;
t1=(0:N1-1)*T; %ʱ������
x1=(0:N1-1)*T;
% F=1/(T*N1);
% w=2*pi*F;
% k1=floor((-(N1-1)/2):((N1-1)/2));  % y=floor(x)������x��Ԫ��ȡ����ֵyΪ�����ڱ�����������
% f=k1*w;
f=(-N1/2:N1/2-1)*1/T/N1;
X1=fftshift(fft(x1,N1))/(N1/2);
figure;
subplot(3,1,1);
plot(t1,x1);
xlabel('t');
ylabel('x(t)');
subplot(3,1,2);
plot(f,abs(X1));
xlabel('w');
ylabel('|X(w)|');
subplot(3,1,3);
plot(f,angle(X1));
xlabel('w');
ylabel('angle(X(w))');
sgtitle('����16�㣬16��FFT')


% ʱ������ĩβ�ֶ�����(����1024������)��������FFT����(1024��)
% ����1024�㣬1024��FFT 
N2=1024;
x2=[x1,zeros(1,1008)];
t2=(0:N2-1)*T;
% F2=1/(T*N2);
% w2=2*pi*F2;
% k2=floor((-(N2-1)/2):((N2-1)/2));
% f2=k2*w2;
f2=(-N2/2:N2/2-1)*1/T/N2;
X2=fftshift(fft(x2,N2))/(N2/2);
figure;
subplot(3,1,1);
plot(t2,x2);
xlabel('t');
ylabel('x(t)');
subplot(3,1,2);
plot(f2,abs(X2));
xlabel('w');
ylabel('|X(w)|');
subplot(3,1,3);
plot(f2,angle(X2));
xlabel('w');
ylabel('angle(X(w))');
sgtitle('ʱ������ĩβ�ֶ�����(����1024������)��������FFT����(1024��)')

% ʱ�����в��䣬ֻ����FFT����(1024��)
% ����16�㣬1024��FFT 
X3=fftshift(fft(x1,N2))/(N2/2);
figure;
subplot(3,1,1);
plot(t1,x1);
xlabel('t');
ylabel('x(t)');
subplot(3,1,2);
plot(f2,abs(X3));
xlabel('w');
ylabel('|X(w)|');
subplot(3,1,3);
plot(f2,angle(X3));
xlabel('w');
ylabel('angle(X(w))');
sgtitle('ʱ�����в���(16��)��ֻ����FFT����(1024��)')

