clc;
clear;
close all;
%

data = load('data.mat');
data = data.data;

for i = 1:length(data)
    disp(['saving file ' num2str(i)]);
    inchunk = data{i}{1};
    inwords = data{i}{2};
    outroom = data{i}{3};
    outobj = data{i}{4};
    outref = data{i}{5};
    outdir = data{i}{6};
    outtar = data{i}{7};
    
    fileID = fopen(['vec/' num2str(i) '.txt'],'w');
    fprintf(fileID,'inchunk\n');
    fprintf(fileID,'%s\n',num2str(inchunk));
    fprintf(fileID,'inwords\n');
    for r = 1:size(inwords,1)
        fprintf(fileID,'%s\n',num2str(inwords(r,:)));
    end
    
    fprintf(fileID,'outroom\n');
    fprintf(fileID,'%s\n',num2str(outroom));
    fprintf(fileID,'outobj\n');
    fprintf(fileID,'%s\n',num2str(outobj));
    fprintf(fileID,'outref\n');
    fprintf(fileID,'%s\n',num2str(outref));
    fprintf(fileID,'outdir\n');
    fprintf(fileID,'%s\n',num2str(outdir));
    fprintf(fileID,'outtar\n');
    fprintf(fileID,'%s\n',num2str(outtar));
    fclose(fileID);
end