function x_candidates = Hv_Select(Problem, Arc, N, num_infill, Gen_max, num_train)
[x_train, y_train] = SelectTrainData(Arc, num_train);
num_sample = size(x_train,1);
D = size(x_train,2);
% Build surrogate model
ghxd = real(sqrt(x_train.^2*ones(size(x_train'))+ones(size(x_train))*(x_train').^2-2*x_train*(x_train')));
spr = max(max(ghxd))/(D*num_sample)^(1/D);
net = newrbe(x_train',y_train',spr);
x_parent = repmat(Problem.upper-Problem.lower,N,1).*UniformPoint(N,Problem.D,'Latin')+repmat(Problem.lower,N,1);
y_parent = sim(net,x_parent')';
i = 0;
while i < Gen_max
    index1 = randperm(N,N);    index2 = randperm(N,N);
    x_offspring = OperatorDE(Problem,x_parent,x_parent(index1,:),x_parent(index2,:),{1,0.5,1,20});
    y_offspring = sim(net,x_offspring')';
    Mediate_dec = [x_parent; x_offspring];
    Mediate_obj = [y_parent; y_offspring];
    [FrontNo,MaxFNo] = NDSort(Mediate_obj,N);
    Choose = find(FrontNo < MaxFNo);
    Last_PS = find(FrontNo == MaxFNo);
    CD = CrowdingDistance(Mediate_obj(Last_PS,:),FrontNo(Last_PS));
    [~,index] = sort(CD,'descend');
    Choose = [Choose, Last_PS(index(1:(N-sum(FrontNo<MaxFNo))))];
    x_parent = Mediate_dec(Choose,:);
    y_parent = Mediate_obj(Choose,:);
    i = i + 1;
end
[FrontNo,~] = NDSort(y_parent,inf);
Pseudo_PS = x_parent(FrontNo==1,:);
Pseudo_PF = y_parent(FrontNo==1,:);
[FrontNo,~] = NDSort(y_train,inf);
Ymin = min(y_train(FrontNo == 1,:));    Ymax = max(y_train(FrontNo == 1,:));
RefPoint = (Ymax - Ymin).*1.2;
score = [];
for j = 1:size(Pseudo_PS,1)
    x_hv = [x_train; Pseudo_PS(j,:)];    y_hv = [y_train; Pseudo_PF(j,:)];
    [FrontNo,~] = NDSort(y_hv,inf);
    score(j) = CalHV(y_hv(FrontNo==1,:),RefPoint);
end
[~,index] = sort(score,'descend');
if size(Pseudo_PS,1) >= num_infill
    x_candidates = Pseudo_PS(index(1:num_infill),:);
else
    x_candidates = Pseudo_PS(index,:);
end
end
