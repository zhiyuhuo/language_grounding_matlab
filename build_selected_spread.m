function res = build_selected_spread(spread, sent)

res = spread(1, :);

for i = 1:length(sent)
    for j = 1:length(spread)
        if spread{j, 1} == sent(i)
            res(end+1,:) = spread(j, :);
        end
    end
end

end