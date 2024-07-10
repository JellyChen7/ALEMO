function x_candidate = ClassifierSelect(Problem, Arc, N, num_infill)
tr_xx = Arc.decs;
tr_yy = Arc.objs;
D = size(tr_xx,2);
[FrontNo,~] = NDSort(tr_yy,inf);
FrontNo(FrontNo > 4) = 4;
% Construct a classifier
x_train = tr_xx;
distance = pdist2(x_train,x_train);
spr = max(max(distance))/sqrt(2*size(x_train,1));
net_pnn = newpnn(x_train',ind2vec(FrontNo),spr);
[Parent, ~] = SelectTrainData(Arc, N);
index_1st = find(FrontNo == 1);
Offspring = OperatorDE(Problem, Parent, x_train(index_1st(randi(length(index_1st),N,1)),:), Parent, {1,0.5,1,20});
count = 0;
% Evolve offspring
y_label = vec2ind(sim(net_pnn,Parent'));
while sum(y_label == 1)<0.75*N
    index_1st = find(y_label == 1);
    if ~isempty(index_1st)
        Offspring = OperatorDE(Problem, Parent,Parent(index_1st(randi(length(index_1st),N,1)),:), Parent, {1,0.5,1,20});
    else
        Offspring = OperatorDE(Problem, Parent,Parent(randi(N,N,1),:), Parent(randi(N,N,1),:), {1,0.5,1,20});
    end
    Offspring_label = vec2ind(sim(net_pnn,Offspring'));
    Parent(Offspring_label<y_label,:) = Offspring(Offspring_label<y_label,:);
    y_label = Offspring_label;
    count = count + 1;
    if count > 50
        break;
    end
end
[~,index] = sort(min(pdist2(Parent(y_label==1,:), Arc.decs),[],2),'descend');
if length(index)>=num_infill
    x_candidate = Parent(index(1:num_infill),:);
else
    x_candidate = Parent(index,:);
end
end