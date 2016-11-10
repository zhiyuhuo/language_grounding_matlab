function res = p_groundingtype_chunkname(groundingtype, chunkname)

groundingtypeid = 0;
groundingtypelist = {};
fid = fopen('groundings\grounding type.txt');
tline = fgets(fid);
while ischar(tline)
    if (double(tline(end)) < 20)
        str = tline(1:end-2);
    else
        str = tline;
    end
    groundingtypelist{end+1} = str;
%     disp(tline);
    tline = fgets(fid);
end
n = 1;
while n <= length(groundingtypelist)
    if strcmp(groundingtype, groundingtypelist(n)) == 1
        groundingtypeid = n;
        break;
    end
    n = n + 1;
end
if groundingtypeid >= 3
    groundingtypeid = 3;
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
newchunkname = 1;
while n <= length(chunknamelist)
    if strcmp(chunkname, chunknamelist(n)) == 1
        chunknameid = n;
        newchunkname = 0;
        break;
    end
    n = n + 1;
end
fclose(fid);

load('type_chunkname_m.mat');
if newchunkname == 1
    res = 1;
    return;
end
res = m(chunknameid, groundingtypeid);

end