close all;
clear;
clc;
%

table = [];
LOOP = 1;
while LOOP <= 1
    tr = Build_Grounding_Dict();
    Build_WordWeight();
    r = Test_Grounding(tr);
    disp([LOOP r(1) r(2) r(3)]);
    table = [table; r];
    LOOP = LOOP + 1;
end