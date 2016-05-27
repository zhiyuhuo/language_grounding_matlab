% find chunk name ground type distribute
close all;
clear;
clc;

chunknamelist = {};
fid = fopen('groundings\chunk name.txt');
tline = fgets(fid);
while ischar(tline)
    if (double(tline(end)) < 20)
        str = tline(1:end-2);
    else
        str = tline;
    end
    chunknamelist{end+1} = str;
    disp(tline)
    tline = fgets(fid);
end

[num,txt,raw] = xlsread('raw_dataset.xlsx');
m = []

for i = 1:length(chunknamelist)
    chunkdataidx = find(strcmp(raw(:, 2), chunknamelist(i)) == 1);
    catnum = zeros(1, length(chunknamelist));
    name = chunknamelist{i};
    for j = 1:length(chunkdataidx)
        idx = chunkdataidx(j);
        if strcmp(raw(idx, 4), 'N/A') == 0
            catnum(1) = catnum(1) + 1;
        elseif strcmp(raw(idx, 5), 'N/A') == 0
            catnum(2) = catnum(2) + 1;
        elseif strcmp(raw(idx, 6), 'N/A') == 0 || strcmp(raw(idx, 7), 'N/A') == 0 || strcmp(raw(idx, 8), 'N/A') == 0
            catnum(3) = catnum(3) + 1;
        else
            ;
        end
    end
    disp(chunknamelist{i})
    ptypechunkname = catnum / length(chunkdataidx);
    m = [m; ptypechunkname];
end
m
save('type_chunkname_m', 'm');

