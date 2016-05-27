%
% find chunk name ground grounding distribute
close all;
clear;
clc;

groundingname = 'direction';
spreadgroungingcol = 7;

txtfilename = ['groundings\' groundingname '.txt'];
matfilename = [groundingname '_chunkname_m'];

groundinglist = {};
fid = fopen(txtfilename);
tline = fgets(fid);
while ischar(tline)
    if (double(tline(end)) < 20)
        str = tline(1:end-2);
    else
        str = tline;
    end
    groundinglist{end+1} = str;
    disp(tline)
    tline = fgets(fid);
end
fclose(fid);

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
fclose(fid);

[num,txt,raw] = xlsread('raw_dataset.xlsx');
m = []

for i = 1:length(chunknamelist)
    chunkdataidx = find(strcmp(raw(:, 2), chunknamelist(i)) == 1);
    catnum = zeros(1, length(groundinglist));
    name = chunknamelist{i};
    for j = 1:length(chunkdataidx)
        idx = chunkdataidx(j);
        for k = 1:length(groundinglist)
            if strcmp(raw(idx, spreadgroungingcol), groundinglist(k)) == 1
                catnum(k) = catnum(k) + 1;
            else
                ;
            end
        end
    end
    disp(chunknamelist{i})
    groundingchunkname = catnum / length(chunkdataidx);
    m = [m; groundingchunkname];
end
m
save(matfilename, 'm');

