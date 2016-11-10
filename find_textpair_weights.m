function [res1 res2 rawweight1 rawweight2] = find_textpair_weights(tag1, tag2, text1, text2, chunkname, groundingtype, grounding)

d = load(['mats/' groundingtype, '-', grounding, '-wf.mat']);
w = d.w;
for i = 1:length(w)
    subw = w{i};
    if strcmp(subw{1}, chunkname) == 1
        w = subw{2};
        break;
    end
end

L1 = length(text1);
text = [text1 text2];
L = length(text);
rawweight = 0.01 * ones(1, length(text1) + length(text2));
res = 0.01 * ones(1, length(text1) + length(text2));

for i = 1:length(text)
    for j = 1:length(w)
        wcell = w{j};
        wcelltext = wcell{2};
        if strcmp(wcell{1}, text{i}) == 1 && strcmp(wcell{2}, text{i}) == 1
            res(i) = wcell{3};
            rawweight(i) = wcell{3};
        end
    end
end

% validset = find(res > 0.01);
% if length(validset) > 0
%     invalidset = find(res <= 0.01);
%     minvalid = min(res(validset));
%     invalidvalue = minvalid / length(invalidset);
%     length(invalidset);
%     res(invalidset) = invalidvalue;
% end
    
% res = res / sum(res) * L;
res1 = res(1:L1);
res2 = res(L1+1:L);
rawweight1 = rawweight(1:L1);
rawweight2 = rawweight(L1+1:L);

end