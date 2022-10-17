functiondir=cd;
addpath([functiondir '/common'])
addpath([functiondir '/batch process'])
addpath([functiondir '/detection'])
addpath([functiondir '/main'])
addpath([functiondir '/other'])
addpath([functiondir '/PALM'])
addpath([functiondir '/toolbox'])
str = computer;
if isequal(str,'PCWIN64')
    addpath([functiondir '/tracking64'])
else
    addpath([functiondir '/tracking'])
end
run Batch_process;

