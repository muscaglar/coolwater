function [] = coolwater_TDMS_import(fileroot,files)

% [baseName, folder] = uigetfile({'*.dat';'*.mat';},'CoolWater File Selector');
% filepath = fullfile(folder, baseName);
voltage = [];
current = [];
for i = 1:numel(files)
    if(ispc)
        filepath = char(strcat(fileroot,'\',files(i).name));
    else
        filepath = char(strcat(fileroot,'/',files(i).name));
    end
    
    if(i==1)
        result = convertTDMS(0,filepath);
        voltage = result.Data.MeasuredData(3).Data';
        current = result.Data.MeasuredData(4).Data';
    else
        
        if(coolwater_getNumber(files(i).name) == coolwater_getNumber(files(i-1).name))
            result = convertTDMS(0,filepath);
            voltage = [voltage, result.Data.MeasuredData(3).Data'];
            current = [current, result.Data.MeasuredData(4).Data'];
        else
            [voltage, current] = coolwater_removeKickOut(voltage,current);
            coolwater_saveMat(files(i).name,files(i).folder,voltage,current);
            result = convertTDMS(0,filepath);
            voltage = result.Data.MeasuredData(3).Data';
            current = result.Data.MeasuredData(4).Data';
        end
    end
    if(i==numel(files))
        [voltage, current] = coolwater_removeKickOut(voltage,current);
        coolwater_saveMat(files(i).name,files(i).folder,voltage,current);
    end
end

    function [] = coolwater_saveMat(fName,fPath, voltage, current)
        name = ['run',num2str(coolwater_getNumber(fName))];
        if(ispc)
            savepath = strcat(fPath,'\',name);
        else
            savepath = strcat(fPath,'/',name);
        end
        save_mat = char(strcat(savepath,'.mat'));
        save(save_mat,'voltage','current');
    end

    function [number] = coolwater_getNumber(fName)
        out = str2double(regexp(fName,'[\d.]+','match'));
        number = out(1);
    end

    function [voltage, current] = coolwater_removeKickOut(voltage,current)
        bound = mean(voltage);
        index1 = voltage>(bound*1.1);
        index2 = voltage<(bound*0.9);
        index = or(index1,index2);
        index = not(index);
        voltage = voltage(index);
        current = current(index);
        
        bound2 = mean(current);
        index1 = current>(bound2*2);
        index2 = current<(bound2*0.25);
        index = or(index1,index2);
        index = not(index);
        voltage = voltage(index);
        current = current(index);
    end

end