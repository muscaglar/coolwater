function [] = coolwater_alt_process(files)

% [baseName, folder] = uigetfile({'*.dat';'*.mat';},'CoolWater File Selector');
% filepath = fullfile(folder, baseName);
time = 0:1/100000:2000;

for i = 1:numel(files)
    name = strsplit(files(i).name,'.');
    if(ispc)
        full_path = strcat(files(i).folder,'\',files(i).name);
        savepath = strcat(files(i).folder,'\',name{1});
    else
        full_path = strcat(files(i).folder,'/',files(i).name);
        savepath = strcat(files(i).folder,'/',name{1});
    end
    load(full_path);
    
    fig_trace = figure;
    plot(time(1:length(current)),current);
    
    [P, x,y, model_y] = coolwater_alt_process_runPeakFinder(current);
    
    fig_hist = figure;
    plot(x,y);
 
    fig_fit_gauss = figure;
    plot(x,model_y);
    
    save_trace = char(strcat(savepath,'_trace.png'));
    save_hist = char(strcat(savepath,'_hist_fit.png'));
    save_fit = char(strcat(savepath,'_fit.mat'));
    save_P_params = char(strcat(savepath,'_P_params.mat'));
    
    saveas(fig_trace,save_trace);
    saveas(fig_hist,save_hist);
    saveas(fig_fit_gauss,save_fit);
    save(save_P_params,'P');
    
    close all;
end

end


function [P, x,y, model_y] = coolwater_alt_process_runPeakFinder(current)

%load('test_run.mat');

bin_num = 10000;

time = 0:1/100000:2000;
time = time(1:length(current));

[fil_current] = butterworth(100, 10000,current);

plot(fil_current)

H = histogram(fil_current,bin_num);

x = H.BinEdges(1:bin_num);
y = H.Values;

close all;

%plot(x,y);
%[P,A]=autofindpeaks(x,y,20)
%[P] = findpeaksplot(x,y,1e-08,1000,35,35,1)

SlopeThreshold = 1e-8;
AmpThreshold = 3000;
smoothwidth = 35;
peakgroup = 35;
smoothtype = 3;
peakshape = 1;
extra = 0;
NumTrials = 1;
autozero = 0;
fixedparameters= 1;
plots= 1;
displayit = 1;
AUTOZERO = 0;
window = 10;
PeakShape = 1;
ShowPlots = 1;

 P = findpeaksG(x,y,SlopeThreshold,AmpThreshold,smoothwidth,peakgroup,smoothtype)
%[P] =findpeaksb(x,y,SlopeThreshold,AmpThreshold,smoothwidth,peakgroup,smoothtype,window,PeakShape,extra,NumTrials,AUTOZERO)
%FPB=findpeaksb3(x,y,SlopeThreshold,AmpThreshold,smoothwidth,peakgroup,smoothtype,PeakShape,extra,NumTrials,AUTOZERO,ShowPlots);

%P(peak,:) = [round(peak) PeakX PeakY MeasuredWidth  1.0646.*PeakY*MeasuredWidth Error];

model_y = 0;

for i=[1:size(P,1)]
    peakY = P(i,3)*gaussian(x,P(i,2),P(i,4));
    model_y = model_y + peakY;
end

plot(x,model_y);

%[P,FitResults,GOF,LowestError,BestStart,xi,yi] =findpeaksfit(x,y,SlopeThreshold,AmpThreshold,smoothwidth,peakgroup,smoothtype,peakshape,extra,NumTrials,autozero,fixedparameters,plots);
%PS=peakstats(x,y,SlopeThreshold,AmpThreshold,smoothwidth,peakgroup,smoothtype,displayit)
%Get GOF out
%P is 'peak number', 'position', 'height', 'FWHM'
% [pks,locs,w,p] = findpeaks(y,x,'MinPeakHeight',0.2,'MinPeakProminence',5);
%plot(locs,pks);

end