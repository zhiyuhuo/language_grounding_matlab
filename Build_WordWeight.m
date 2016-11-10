function Build_WordWeight()
clc;
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
        build_grounding_word_freq(groundingtypename, groundingname);
    end
end

end