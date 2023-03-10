clc;
close all
clear
N=320
[Y,fs,bits]=WAVREAD('wrd.wav');% 读取的Y是列

fs;
bits;
L=length(Y)%30ms每帧，每秒16000个点,一帧480点

LL=length(Y)/N   %计算帧数
% Yr=zeros(L,1);
% figure(1);subplot(211)
% % plot(Y) %绘制原始信号
% % legend('The orignal speech')
% % axis([0 3e4 -0.5 0.5])
% 
% subplot(212)
% Ys=abs(fft(Y));
% % plot(Ys);
% % legend('The Frequency spectrum')
% % set(1,'Position',[10,35,350,650])

%短时能量  
Em=zeros(1,(LL-1)*N);
for ii=1:(LL-1)*N
    temp=Y(ii:ii+N);
    Em(ii)=sum(temp.*temp);
end
figure(2)
subplot(411)                                    %绘制短时能量
jj=[1:(LL-1)*N];               
plot(jj, Em,'b');
title('(a) 短时能量')
grid
 %短时过零率 
 
Zn=zeros(1,(LL-1)*N);
for ii=2:(LL-1)*N
    temp1=sign(Y(ii:ii+N));
    temp=sign(Y(ii-1:ii+N-1));
    Zn(ii)=sum(abs(temp1-temp));
end
figure(2)
 subplot(4,1,2)
jj=[1:(LL-1)*N];               
plot(jj, Zn,'b');                                     %绘制过零率
title('(b) 短时过零率')
grid
%零能比曲线

figure(2)
subplot(4,1,3)
jj=[1:(LL-1)*N];   
ZER=Zn./Em;
plot(jj, ZER);                                     %绘制零能比曲线
title('(c) 零能比曲线')
grid on





ii=1;
B=zeros(LL,1);
while ii<=(LL-1)*N
 
       if Em(ii)<0.005                             %自己设定能量的阈值
          B(ii)=0;ii=ii+1;
     

       
       
       
       elseif  ZER(ii) <=150        
                
                
                B(ii)=1;ii=ii+1;
                
                
                
                
       else
           B(ii)=-1;ii=ii+1;
       end
end
subplot(414)
plot(B,'.');
title('(d) 清音浊音无声段')

