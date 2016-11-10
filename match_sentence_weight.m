function res = match_sentence_weight(tagsmp, tagtmp, sentsmp, senttmp, chunkname, groundingtype, grounding)

L1 = length(sentsmp);
L2 = length(senttmp);
LMAX = max([L1, L2]);

[wsmp, wtmp, r1, r2] = find_textpair_weights(tagsmp, tagtmp, sentsmp, senttmp, chunkname, groundingtype, grounding);
% [dist, L] = weighted_edit_distance_sent(sentsmp,senttmp, wsmp, wtmp);
[dist, L] = weighted_wordarray_distance_sent(tagsmp, tagtmp, sentsmp,senttmp, wsmp, wtmp);
score = 1 - dist / LMAX;
res = score;

end