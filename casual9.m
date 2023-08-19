%% FFTƵ�׵Ļ���(�Գơ�����)
ccc;
fs=10000;   %������
t=-0.1:1/fs:0.1;   %ʱ������
f1=300;
f2=2000;
f3=3000;
x1=cos(2*pi*f1*t);   
x2=2*sin(2*pi*f2*t);   
x3=4*sin(2*pi*f3*t);   
x=x1;
N=length(x);

%���滭��
ff=(0:N-1)*fs/N;
yy=abs(fft(x))/(N/2);
figure;
subplot(2,2,1)
plot(ff,yy);
xlabel('Ƶ��/Hz');
ylabel('���');
title('���滭��');
grid on;

%��x=0Ϊ��Գƻ���
f=(-N/2:N/2-1)*fs/N;
y=fftshift(abs(fft(x)))/(N/2);
subplot(2,2,2)
plot(f,y);
xlabel('Ƶ��/Hz');
ylabel('���');
title('��x=0Ϊ��Գƻ���');
grid on;

%���߻���
%����۵�Ƶ��֮ǰ,(0~fs/2)��Χ�ڵ�Ƶ��
subplot(2,2,3)
plot(ff(1:floor(N/2)),yy(1:floor(N/2)));
xlabel('Ƶ��/Hz');
ylabel('���');
title('(0~fs/2)��Χ�ڵĵ���Ƶ��');
grid on;

%���߻���
%hilbert(),ϣ�����ر任Ҳʵ����˫���׵������׵�ת��������������ȼӱ�,��Ҫ����2
subplot(2,2,4)
plot(ff,abs(fft(hilbert(x),N))/(N/2)/2);
xlabel('Ƶ��/Hz');
ylabel('���');
title('ϣ�����ر任ʵ�ֵ���Ƶ��');
grid on;
sgtitle('FFTƵ�׵Ļ���(�Գơ�����)','color','black','Fontsize',20) %����ͼ���ܱ���