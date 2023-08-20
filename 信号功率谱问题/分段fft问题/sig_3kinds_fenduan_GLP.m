%% 分段+pwelch法，标准功率谱的求法 （幅值为1的正弦信号、复信号的标准功率谱分别应该是-3dB 和 0dB)
% 分成'duanshu'个数据段分别做psd再取平均，并只取单边psd，因此最后点数变为length(y)/duanshu/2
ccc;
f0=10e3;
fs=60e3;
ts=1/fs;
SNR=6;
t=0:ts:10-ts;
N1=length(t);
s1={cos(2*pi*f0*t) ; exp(1j*2*pi*f0*t) ; [zeros(1,N1) cos(2*pi*f0*t) zeros(1,N1)]}; % 正弦信号和复信号
t1=(0:3*N1-1)*ts;
N2=length(t1);
noise=randn(1,N1);
b=fir1(256,[5e3,15e3]/(fs/2));          
noise1=filter(b,1,noise);                 
noise2=noise1/std(noise1);              %归一化
for i=1:2
    px(i)=norm(s1{i}).^2/N1;      %计算输入信号的功率
    pn(i)=px(i)./(10.^(SNR./10));       %根据snr计算噪声功率
    noise3(i,:)=noise2*sqrt(pn(i));
end

noise_=randn(1,3*N1);
b_=fir1(256,[5e3,15e3]/(fs/2));          
noise1_=filter(b_,1,noise_);                 
noise2_=noise1_/std(noise1_);              %归一化
px_=norm(s1{3,:}).^2/N1;      %计算输入信号的功率
pn_=px_./(10.^(SNR./10));       %根据snr计算噪声功率
noise3_=noise2_*sqrt(pn_);

%不带噪声的信号
figure;
subplot(311)
plot(t,s1{1});
title('不带噪信号1时域波形 ');
xlabel('时间')
ylabel('幅度')
subplot(312)
plot(t,real(s1{2}));
title('不带噪信号2时域波形 ');
xlabel('时间')
ylabel('幅度')
subplot(313)
plot(t1,(s1{3}));
title('不带噪信号3时域波形 ');
xlabel('时间')
ylabel('幅度')



%叠加信号
for i=1:2
d{i,:}=s1{i}+noise3(i,:);
end
d{3,:}=s1{3}+noise3_;
figure;
subplot(311)
plot(t,d{1});
title('叠加噪声信号1时域波形 ');
xlabel('时间')
ylabel('幅度')
subplot(312)
plot(t,real(d{2}));
title('叠加噪声信号2时域波形 ');
xlabel('时间')
ylabel('幅度')
subplot(313)
plot(t1,(d{3}));
title('叠加噪声信号3时域波形 ');
xlabel('时间')
ylabel('幅度')

% 标准功率谱
% 分段周期图法是在周期图法的基础上，为了减少结果的方差而出现的。
% 其过程：将长度为N的采样数据分为K段，每一段由M个样本组成，分别计算每一段的FFT，
% 对结果进行平均（目的是减少方差）。但这样做也导致功率谱的分辨率降低了。
% 分成'duanshu'个数据段分别做psd再取平均，并只取单边psd，因此最后点数变为length(y)/duanshu/2
psdData1=GLPs(d{1},fs,0,10);
psdData2=GLPs(d{2},fs,0,10);
psdData3=GLPs(d{3},fs,0,10);
figure
subplot(3,1,1)
plot(psdData1(:,1),psdData1(:,2))
subplot(3,1,2)
plot(psdData2(:,1),psdData2(:,2))
subplot(3,1,3)
plot(psdData3(:,1),psdData3(:,2))