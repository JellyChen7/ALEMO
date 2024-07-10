clc,clear
% Before running this code, COMSOL Multiphysics with MATLAB need to be installed.
addpath(genpath(cd));
iter = 10;

for j = 1:iter
    platemo('algorithm',@NSGAII,'problem',@forward_simulation,'M',2,'D',80,'maxFE',5000, 'save',1);
    platemo('algorithm',@MOEAD,'problem',@forward_simulation,'M',2,'D',80,'maxFE',5000, 'save',1);
    platemo('algorithm',@CSEA,'problem',@forward_simulation,'M',2,'D',80,'maxFE',500, 'save',1);
    platemo('algorithm',@MCEAD,'problem',@forward_simulation,'M',2,'D',80,'maxFE',500, 'save',1);
    platemo('algorithm',@CPSMOEA,'problem',@forward_simulation,'M',2,'D',80,'maxFE',500, 'save',1);
    platemo('algorithm',@ALEMO,'problem',@forward_simulation,'M',2,'D',80,'maxFE',500, 'save',1);
end
