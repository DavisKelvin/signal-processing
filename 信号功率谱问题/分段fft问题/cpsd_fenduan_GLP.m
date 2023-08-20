function [psdData1,Var_psd1]=cpsd_fenduan_GLP(data,fs,fangda,duanshu)
Py=[];
Py_Add=0;
changdu=floor(length(data)/duanshu); %截取的每一段数据的长度，也即
% changdu=floor(length(data)/duanshu)=floor(T0/ts/duanshu)=floor(T0/duanshu*fs)=floor(Δt*fs)；T0是原信号总时长，Δt是每一段数据的时长
% 又:频率分辨率df=fs/length(changdu)=fs/(Δt*fs)=1/Δt，所以changdu=floor(Δt*fs)=floor(fs/df)
% 因此也可以表达为：changdu=floor(fs/df)，这种表达可以直接定义频率分辨率df，如1Hz，此时有duanshu=length(data)/fs,在函数外应给予此定义
for i=1:duanshu
    shuju=data((i-1)*changdu+1:i*changdu); %截取的第i段数据
    % i=1,shuju=data(1:changdu)
    % i=2,shuju=data(changdu+1:2changdu)
    % i=3,shuju=data(2changdu+1:3changdu)
    % ......
    % i=100,shuju=data(99changdu+1:100changdu)
    nfft=length(shuju);
    window=boxcar(nfft);
    %  [pxy,f] = cpsd(x,y,window,noverlap,nfft,fs)
    [pp,ff]=cpsd(shuju, shuju, window, [], nfft, fs); % pp,ff均以列向量返回，无论输入数据是行向量还是列向量
    pp=pp*fs/2;
    pp(1)=pp(1)*2;
    pp(length(pp))=pp(length(pp))*2;
    rs=2*norm(window).^2/sum(window).^2; % 计算窗函数的能量
    Py=pp*rs;
    Py_Add = Py_Add+Py;
end
Py_Add = Py_Add/duanshu;
Var_psd1=var(Py_Add);
Lg=10*log10(Py_Add)+fangda;
psdData1=[ff,Lg];
end