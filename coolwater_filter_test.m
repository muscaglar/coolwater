
close all;
clear all;
clc;
load('/Users/Mus/Downloads/Adrian_Translocation_Data/Processed_Mat_Files/untitled folder/run8.mat');
f_s=100e3;
N=length(current);
t=[0:N-1]/f_s; 

% freq = 500;
% freq_low = 400;
% freq_high = 600;
% 
% w0 = freq/(f_s/2);  bw = w0/40;
% 
% w1 = freq_low/(f_s/2);
% w2 = freq_high/(f_s/2);
% 
% [num,den]=iirnotch(w0,bw); 
% 
% [b,a] = butter(1,[w1 w2],'stop');
% 
% freqz(b,a)
% 
% %current_notch=filtfilt(num,den,current);
% current_notch=filtfilt(b,a,current);
% current_notch=filtfilt(b,a,current_notch);
% current_notch=filtfilt(b,a,current_notch);

N1=length(current_notch);
t1=[0:N1-1]/f_s;

figure, plot(t(7795001:7800001),current(7795001:7800001),'r'); title('Plotting a small section')             
xlabel('time')
ylabel('amplitude')
hold on
plot(t1(7795001:7800001),current_notch(7795001:7800001),'g');             
legend('ORIGINAL SIGNAL',' Flitered SIGNAL')
hold off
