function res = Build_Grounding_Dict()

%
[num,txt,raw] = xlsread('raw_dataset.xlsx');

randselect = randsample(149, 72);
raw = build_selected_spread(raw, randselect);

fid = fopen('groundings\grounding type.txt');
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

for i = 1:length(groundingtypelist)
    groundingtypename = groundingtypelist{i};
    groundingfilename = ['groundings\' groundingtypename '.txt'];
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
        r = extract_grounding(raw, groundingtypename, groundingname);
        save(['mats\' groundingtypename '-' groundingname], 'r');
    end
end

res = randselect;
end