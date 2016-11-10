function [tag text] = extract_chunk_content(chunkcell)

chunk = chunkcell{1};
S = length(chunk);

c = [];
cc = {};

n = 1;
while n <= S
    if n >= 1
        if chunk(n) ~= ' '
            c = [c chunk(n)];
        end
    end
    
    if n > 1
        if chunk(n) == ' '
            cc{end+1} = c;
            c = [];
        elseif n == S
            cc{end+1} = c;
        end
    end 
    
    n = n + 1;
end

tag = {};
text = {};

for i = 1:2:length(cc)
    tag{end+1} = cc{i};
    text{end+1} = cc{i+1};
end

end