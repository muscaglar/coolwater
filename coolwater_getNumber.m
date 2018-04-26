    function [number] = coolwater_getNumber(fName)
        out = str2double(regexp(fName,'[\d.]+','match'));
        number = out(1);
    end