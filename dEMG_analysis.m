%% plot + butterworth + root mean square(rms)
% z-score
n_1 = 1;
n_2 = n_1 +1000;
n_1_dia=n_1*Fs_dia;
n_2_dia=n_2*Fs_dia;
t_1_dia=(n_1_dia-1)/Fs_dia:1/Fs_dia:(n_2_dia-1)/Fs_dia;
y4=z_1(n_1_dia:n_2_dia);
enve_= envelope(y4,50,"rms");
figure(1);
plot(t_1_dia,enve_,'linewidth',1.5);
%% find burst stim
burst=find_burst_duration(enve_,0.0012,0.2*Fs_dia);%data;amplitude min;duration limit 
%% frequecy, duration and amplitude analysis
    n_all=length(burst(:,1));
frequency_all=n_all*60/(n_2-n_1) %/min
duration_all=mean(burst(:,3)-burst(:,2))/Fs_dia %s
amplitude_all=[];
for i=1:length(burst(:,1))

    amplitude= max(y4(1,burst(i,2):burst(i,3)));
    amplitude_all=[amplitude_all; amplitude];
end
mean(amplitude_all) %z-score
                                                             