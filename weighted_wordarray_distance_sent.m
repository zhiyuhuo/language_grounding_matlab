function [dist,L] = weighted_wordarray_distance_sent(tag1, tag2, sent1, sent2, weight1, weight2)

L1 = length(sent1)+1;
L2 = length(sent2)+1;
L = zeros(L1,L2);

g = +1;%just constant
m = +0;%match is cheaper, we seek to minimize
d = +1;%not-a-match is more costly.

%do BC's
L(:,1) = ([0:L1-1] .* [0 weight1])';
L(1,:) = [0:L2-1] .* [0 weight2];

m4=0;%loop invariant
for idx = 2:L1;
    for idy = 2:L2
        if strcmp(sent1{idx-1}, sent2{idy-1}) == 1 && strcmp(tag1{idx-1}, tag2{idy-1})
            score = m;
        else
            score = max(weight1(idx-1), weight2(idy-1));
        end
        m1 = L(idx-1,idy-1) + score;
        if length(weight2) == 3 && idy == 4
        end
        m2 = L(idx-1,idy) + L1 * weight1(idx-1);
        m3 = L(idx,idy-1) + L2 * weight2(idy-1);
        L(idx,idy) = min(m1,min(m2,m3));
    end
end

dist = L(L1,L2);
return

end