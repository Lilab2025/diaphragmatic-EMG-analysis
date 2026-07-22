%% read TDT signals
SDKPATH = 'D:\Desktop\protocal\code\matlab_code\TDTSDK';
addpath(genpath(SDKPATH));
data_TDT=TDTbin2mat('');
 dEMG1=data_TDT.streams.x1___.data;
 dEMG2=data_TDT.streams.x2___.data;
 dEMG3=data_TDT.streams.x3___.data;
 dEMG4=data_TDT.streams.x4___.data; 
%% z-score + butterworth
Fs_dia=3.051757812500000e+03;
n1=1;
n2=2563; 
n_1 = 1;
n_2 = 10;
n_1_dia=n_1*Fs_dia;
n_2_dia=n_2*Fs_dia;
t_1_dia=(n_1_dia-1)/Fs_dia:1/Fs_dia:(n_2_dia-1)/Fs_dia;
z_1=(dEMG1-mean(dEMG1))./std(dEMG1);
y_1=butterworth_filter(z_1,Fs_dia,n1,n2,n_1,n_2,-10,10); % butterworth_filter
z_2=(dEMG2-mean(dEMG2))./std(dEMG2);
y_2=butterworth_filter(z_2,Fs_dia,n1,n2,n_1,n_2,-10,10); % butterworth_filter
z_3=(dEMG3-mean(dEMG3))./std(dEMG3);
y_3=butterworth_filter(z_3,Fs_dia,n1,n2,n_1,n_2,-10,10); % butterworth_filter
z_4=(dEMG4-mean(dEMG4))./std(dEMG4);
y_4=butterworth_filter(z_4,Fs_dia,n1,n2,n_1,n_2,-10,10); % butterworth_filter
%% find burst, and analyze frequency, amplitude and duration of dEMG
n_1 = 5;
n_2 = n_1 +100;
a = [];
for i= n_1:5:n_2;             
    time1 = i-3;
    time2 = i+3;
    time3 = i;
    y = y_1(time1*Fs_dia:time2*Fs_dia);
    enve= envelope(y,100,"rms");
    burst=find_burst_duration(enve,0.1,0.08*Fs_dia);
    n=length(burst(:,1));
    frequency=n*60/(time2-time1);
    duration=mean(burst(:,3)-burst(:,2))/Fs_dia;
    amplitude=[];
    for j=1:length(burst(:,1))
        amplitude_b= max(y(1,burst(j,2):burst(j,3)));
        amplitude=[amplitude; amplitude_b];
    end
    a = [a;[time3 frequency duration mean(amplitude)]];
end                                                          
