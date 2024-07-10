clc,clear
addpath(genpath(cd));
Problems = {'DTLZ1','DTLZ2','DTLZ3','DTLZ4','DTLZ5','DTLZ6','DTLZ7',...
    'ZDT1','ZDT2','ZDT3','ZDT4','ZDT6'};
for i = 1:11
    Problem=Problems{i};
    iter = 20;
    for j = 1:iter
        platemo('algorithm',@ALEMO,'problem',str2func(Problem),'M',2,'D',10,'maxFE',300, 'save',1);
        platemo('algorithm',@ALEMO,'problem',str2func(Problem),'M',2,'D',20,'maxFE',300, 'save',1);
        platemo('algorithm',@ALEMO,'problem',str2func(Problem),'M',2,'D',30,'maxFE',300, 'save',1);
    end
end

