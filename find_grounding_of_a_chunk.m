function [label pvar] = find_grounding_of_a_chunk(chunksmp)

chunkname = chunksmp{1};
chunktext = chunksmp{3};
% grounding label
label = {'N/A', 'N/A', 'N/A', 'N/A', 'N/A'};
pvar = [0 0 0 0 0];

% find grounding
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
    tline = fgets(fid);
end
fclose(fid);

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
        tline = fgets(fid);
    end
    
    for j = 1:length(groundinglist)
        groundingname = groundinglist{j};
        score = match_chunk(chunksmp, groundingtypename, groundingname);
        if score > pvar(i)
            pvar(i) = score;
            label{i} = groundingname;
        end
    end
    fclose(fid);
end

end