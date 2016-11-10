function res = id2vec(id, D)

res = zeros(1,D);
if id <= D
    res(id) = 1;
end

end