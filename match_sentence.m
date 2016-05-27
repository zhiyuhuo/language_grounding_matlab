function res = match_sentence(sentsmp, senttmp)

L1 = length(sentsmp);
L2 = length(senttmp);
LMAX = max([L1, L2]);

[dist, L] = levenshtein_distance_sent(sentsmp,senttmp);
score = 1 - dist / LMAX;
res = score;

end