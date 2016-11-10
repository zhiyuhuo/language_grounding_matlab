function res = Test_Grounding(trainingset)

%
filename = 'raw_dataset.xlsx';
[num,txt,raw] = xlsread(filename);
testingset = setdiff([1:max(num)]', trainingset);
if strcmp(filename, 'real_data_50.xlsx')
    testingset = [1:50];
end
misscase = 0;
wrongcmd = [];
CHUNKNUM = 0;
CMDNUM = length(testingset);

for m = 1:length(testingset)
    testindex = find(num == testingset(m));
    testindex = testindex + 1;
for n = 1:length(testindex) 
    CHUNKNUM = CHUNKNUM + 1;
    i = testindex(n);
    disp([m n]);
    chunkname = raw(i, 2);
    [chunktag chunktext] = extract_chunk_content(raw(i, 3));
    sample = {chunkname, chunktag, chunktext};
    [label, pvar] = find_grounding_of_a_chunk(sample);
    labelgth = {raw{i, 4}, raw{i, 5}, raw{i, 6}, raw{i, 7}, raw{i, 8}};
    match = 1;
    valid = 0;
    for k = 1:length(label)
        if strcmp(label{k}, labelgth{k}) == 0
            match = 0;
            if strcmp(labelgth{k}, 'N/A') == 0
                valid = 1;
            end
        end
    end
    if match == 0 && valid == 1
        disp(i);
        disp(chunkname);
        disp(chunktext);
        disp(label);
        disp(labelgth);
        misscase = misscase + 1;
        wrongcmd = [wrongcmd raw{i, 1}];
    end
end
end

res = [1-misscase/CHUNKNUM, 1-length(unique(wrongcmd))/CMDNUM, CMDNUM-length(unique(wrongcmd))];
end