%% 分段功率谱（下面GLP()，cpsd_fenduan_glp()的结果一致，推荐使用）
% 分段周期图法是在周期图法的基础上，为了减少结果的方差而出现的。
% 其过程：将长度为N的采样数据分为K段，每一段由M个样本组成，分别计算每一段的FFT，
% 对结果进行平均（目的是减少方差）。但这样做也导致功率谱的分辨率降低了。
% 分成'duanshu'个数据段分别做psd再取平均，并只取单边psd，因此最后点数变为length(y)/duanshu/2
ccc;
f0=10e3;
fs=60e3;
ts=1/fs;
SNR=3;
t=0:ts:10e-3-ts;
s=cos(2*pi*f0*t);
% cw信号在时域上的4种形式
cw=s;
% cw=[zeros(1,length(s)) s zeros(1,length(s))];
% cw=[zeros(1,length(s)) s];
% cw=[s zeros(1,length(s))];

%产生带限白噪声
N=length(cw);
t1=(0:N-1)*ts;
noise=randn(1,N);
b=fir1(256,[5e3,15e3]/(fs/2));          %带通滤波器；  注意：fir1(n,Wn)中的 Wn 是一个归一化频率，滤波器设计中需除上(fs/2)进行归一。
noise1=filter(b,1,noise);                  %噪声通过滤波器
noise2=noise1/std(noise1);              %归一化
px=norm(cw).^2/N;      %计算输入信号的功率
pn=px./(10.^(SNR./10));       %根据snr计算噪声功率
noise3=noise2*sqrt(pn);

%叠加信号
d=cw+noise3;


%% 直接pwelch()，该函数是先分段，再平均，但得到的功率谱密度值不是标准值
figure;
duanshu=5;
% duanshu=length(y)/Fs; % 该定义可使频率分辨率为1Hz
window1=boxcar(N/duanshu); %矩形窗,窗长不能大于信号长度！！！
window2=hamming(100); %海明窗
window3=blackman(100); %blackman窗
noverlap=length(window1)/2; %指定分段重叠的样本数,通常取 33%~50%窗长
range='onesided'; %频率范围为[0 fs/2]，只计算一半的频率
% [Pxx3,f2]=pwelch(d,window1,noverlap,fs,fs,range);
[Pxx31,f2]=pwelch(d,window1,noverlap,fs,fs);
logPxx31=10*log10(Pxx31);
plot(f2,logPxx31); 
title('修正周期图法 pwelch()');
xlabel('频率')
ylabel('功率谱/dB')
Var_pwelch=var(Pxx31/duanshu);

%% 利用pwelch()函数修正后的分段功率谱密度函数GLPs()
fangda=0;
[psdData,Var_psd]=GLPs(d,fs,fangda,duanshu);
figure;
plot(psdData(:,1),psdData(:,2))

%% 利用cpsd()函数修正后的分段功率谱密度函数cpsd_fenduan_glp()
fangda=0;
[psdData1,Var_psd1]=cpsd_fenduan_GLP(d,fs,fangda,duanshu);
figure;
plot(psdData1(:,1),psdData1(:,2))

%% 知乎 自定义周期图功率谱函数zhihu_fenduan_glp()，仍有误差
% https://www.zhihu.com/collection/682800573
fangda=0;
[psdData2,Var_psd2]=zhihu_fenduan_glp(d,fs,fangda,duanshu);
figure;
plot(psdData2(1,1:N/duanshu/2),psdData2(2,1:N/duanshu/2))






