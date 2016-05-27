function res = match_chunk(chunksmp, groundingtype, grounding)

sp = chunksmp;
g = load(['mats/' groundingtype '-' grounding '.mat']);
g = g.r;
p = p_groundingtype_chunkname(groundingtype, sp{1});
score = 0;
for i = 1:length(g)
    gt = g{i};
    if strcmp(sp{1}, gt{1}) == 1
        chunkname = sp{1};
%         sc = match_sentence(sp{3}, gt{3});
        sc = match_sentence_weight(sp{2}, gt{2}, sp{3}, gt{3}, chunkname, groundingtype, grounding);
        if sc > score
            score = sc;
        end
    end
end

res = p * score;

end