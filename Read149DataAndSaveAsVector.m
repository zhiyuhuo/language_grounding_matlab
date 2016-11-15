clc;
clear;
close all;
%

[num,txt,raw] = xlsread('raw_dataset.xlsx');
table = txt(2:end,2:end);

invalidline = [];
for i = 1:size(table,1)
    for j = 1:size(table, 2)
        if isempty(table{i,j})
            invalidline(end+1) = i;
        end
    end
end
table = table(setdiff([1:size(table,1)], invalidline), :);

chunks = table(:,1);
chunkdic = unique(chunks);
chunkdic{end+1} = 'N/A';

worddic = {};
txts = table(:,2);
for i = 1:size(txts,1)
    rawtxt = txts{i,:};
    if isempty(rawtxt)
        continue;
    end
    
    if rawtxt(1) == ' '
        rawtxt = rawtxt(2:end);
    end
    txt = strsplit(rawtxt);
    txt = txt(2:2:end);
    for w = 1:length(txt)
        worddic{end+1} = txt{w};
    end
    txts{i} = txt;
end
worddic = unique(worddic);
worddic{end+1} = 'N/A';

roomdic = setdiff(unique(table(:,3)), 'N/A');
objdic = setdiff(unique(table(:,4)), 'N/A');
refdic = setdiff(unique(table(:,5)), 'N/A');
dirdic = setdiff(unique(table(:,6)), 'N/A');
tardic = setdiff(unique(table(:,7)), 'N/A');

%%%% write to dic
fileID = fopen(['vec/dic.txt'],'w');
fprintf(fileID,'chunkdic:\n');
for i = 1:length(chunkdic)
    fprintf(fileID,'%s,', chunkdic{i});
end
fprintf(fileID, '\n');
fprintf(fileID,'worddic:\n');
for i = 1:length(worddic)
    fprintf(fileID,'%s,', worddic{i});
end
fprintf(fileID, '\n');
fprintf(fileID,'roomdic:\n');
for i = 1:length(roomdic)
    fprintf(fileID,'%s,', roomdic{i});
end
fprintf(fileID, '\n');
fprintf(fileID,'objdic:\n');
for i = 1:length(objdic)
    fprintf(fileID,'%s,', objdic{i});
end
fprintf(fileID, '\n');
fprintf(fileID,'refdic:\n');
for i = 1:length(refdic)
    fprintf(fileID,'%s,', refdic{i});
end
fprintf(fileID, '\n');
fprintf(fileID,'dirdic:\n');
for i = 1:length(dirdic)
    fprintf(fileID,'%s,', dirdic{i});
end
fprintf(fileID, '\n');
fprintf(fileID,'tardic:\n');
for i = 1:length(tardic)
    fprintf(fileID,'%s,', tardic{i});
end
fprintf(fileID, '\n');
fclose(fileID);

%%%% write to mat format data file
data = {};
for i = 1:size(table,1)
    numchunk = find(strcmp(chunkdic,chunks{i,1}));
    featurechunk = id2vec(numchunk, length(chunkdic));
    
    numword = [];
    featurewords = [];
    for w = 1:length(txts{i})
        numword = find(strcmp(worddic,txts{i}{w}));
        featurewords = [featurewords; id2vec(numword, length(worddic))];
    end
    
    numroom = find(strcmp(roomdic,table{i,3}));
    labelroom = id2vec(numroom, size(roomdic,1));
    
    numobj = find(strcmp(objdic,table{i,4}));
    labelobj = id2vec(numobj, size(objdic,1));
    
    numref = find(strcmp(refdic,table{i,5}));
    labelref = id2vec(numref, size(refdic,1));
    
    numdir = find(strcmp(dirdic,table{i,6}));
    labeldir = id2vec(numdir, size(dirdic,1));
    
    numtar = find(strcmp(tardic,table{i,7}));
    labeltar = id2vec(numtar, size(tardic,1));
    
    data{end+1} = {featurechunk, featurewords, labelroom, labelobj, labelref, labeldir, labeltar};
end

save('data.mat', 'data');



