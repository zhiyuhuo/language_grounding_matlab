function res = p_grounding_chunkname(grounding, groundingtype, chunkname)

groundingid = 0;
groundinglist = {};
fid = fopen(['groundings\' groundingtype '.txt']);
tline = fgets(fid);
while ischar(tline)
    if (double(tline(end)) < 20)
        str = tline(1:end-2);
    else
        str = tline;
    end
    groundinglist{end+1} = str;
%     disp(tline);
    tline = fgets(fid);
end
n = 1;
while n <= length(groundinglist)
    if strcmp(grounding, groundinglist(n)) == 1
        groundingid = n;
        break;
    end
    n = n + 1;
end
fclose(fid);

chunknameid = 0;
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
%     disp(tline);
    tline = fgets(fid);
end
n = 1;
while n <= length(chunknamelist)
    if strcmp(chunkname, chunknamelist(n)) == 1
        chunknameid = n;
        break;
    end
    n = n + 1;
end
fclose(fid);

d = load([groundingtype '_chunkname_m.mat']);
m = d.m;
res = m(chunknameid, groundingid);

end