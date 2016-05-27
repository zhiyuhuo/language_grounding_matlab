function res = extract_grounding(spread, groundingtype, grounding)
   
title = spread(1,:);
col = 0;
for i = 1:length(title)
    if strcmp(title{i}, groundingtype) == 1
        col = i;
        break;
    end
end

g = spread(1:end, col);

res = {};
idx = [];
for i = 2:length(g)
    if strcmp(g(i), grounding) == 1
        chunkname = spread(i, 2);
        [chunktag chunktext] = extract_chunk_content(spread(i, 3));
        res{end+1} = {chunkname, chunktag, chunktext};
    end
end

end