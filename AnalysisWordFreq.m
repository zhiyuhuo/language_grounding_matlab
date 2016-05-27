close all;
clear;
clc;
%
groundingnum = 0;
fid = fopen('groundings/grounding type.txt');
tline = fgets(fid);
groundingtypelist = {};
while ischar(tline)
    if (double(tline(end)) < 20)
        str = tline(1:end-2);
    else
        str = tline;
    end
    groundingtypelist{end+1} = str;
%     disp(tline)
    tline = fgets(fid);
end
wordlist = {};
for i = 1:length(groundingtypelist)
    groundingtypename = groundingtypelist{i};
    groundingfilename = ['groundings/' groundingtypename '.txt'];
    fid = fopen(groundingfilename);
    tline = fgets(fid);
    groundinglist = {};
    while ischar(tline)
        if (double(tline(end)) < 20)
            str = tline(1:end-2);
        else
            str = tline;
        end
        groundinglist{end+1} = str;
%         disp(tline)
        tline = fgets(fid);
    end
    
    for j = 1:length(groundinglist)
        groundingname = groundinglist{j};
        groundingnum = groundingnum + 1;
        matfilename = ['mats/' groundingtypename '-' groundingname '.mat'];
        R = load(matfilename);
        data = R.r;
        for k = 1:length(data)
            chunk = data{k};
            text = chunk{2};
            for m = 1:length(text)
                wordlist{end+1} = text{m};
            end
        end
        
    end
end

wordlist = unique(wordlist);
wordfreq = zeros(length(wordlist), 1);
ifappear1 = 0;
ifappear2 = 0;

for n = 1:length(wordlist)
    for i = 1:length(groundingtypelist)
        ifappear2 = 0;
        groundingtypename = groundingtypelist{i};
        groundingfilename = ['groundings/' groundingtypename '.txt'];
        fid = fopen(groundingfilename);
        tline = fgets(fid);
        groundinglist = {};
        while ischar(tline)
            if (double(tline(end)) < 20)
                str = tline(1:end-2);
            else
                str = tline;
            end
            groundinglist{end+1} = str;
            tline = fgets(fid);
        end

        for j = 1:length(groundinglist)
            ifappear1 = 0;
            groundingname = groundinglist{j};
            matfilename = ['mats/' groundingtypename '-' groundingname '.mat'];
            R = load(matfilename);
            data = R.r;
            for k = 1:length(data)
                chunk = data{k};
                text = chunk{2};
                for m = 1:length(text)
                    if strcmp(wordlist{n}, text{m}) == 1    
                        wordfreq(n) = wordfreq(n) + 1;
                        ifappear1 = 1;
                        break;
                    end
                end
                if ifappear1 == 1
                    ifappear2 = 1;
                    break;
                end
            end
        end
        if ifappear2 == 1
            break;
        end
    end
end

wordfreq = wordfreq / 5