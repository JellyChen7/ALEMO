classdef ALEMO < ALGORITHM
    % <multi/many> <real/integer> <expensive>
    % Classifier and Local Model-Based Evolutionary Algorithm
    % num_infill    ---    1 --- Number of infill samples for each strategy
    % epsilon       --- 1e-3 --- minimum distance with archive points
    % Gen_max       --- 50   --- Maximum evolving generations
    % num_train       --- 100  --- Number of solutions to build local model
    
    %------------------------------- Reference --------------------------------
    % G. Chen, J. J. Jiao, Q. Liu, Z. Wang, Y. Jin, 2024, Machine Learning-Accelerated 
    % Discovery of Optimal Multi-Objective Fractured Geothermal System Design
    %------------------------------- Copyright --------------------------------
    % Copyright (c) 2022 BIMK Group. You are free to use the PlatEMO for
    % research purposes. All publications which use this platform or any code
    % in the platform should acknowledge the use of "PlatEMO" and reference "Ye
    % Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
    % for evolutionary multi-objective optimization [educational forum], IEEE
    % Computational Intelligence Magazine, 2017, 12(4): 73-87".
    %--------------------------------------------------------------------------
    
    % This function is written by Guodong Chen
    
    methods
        function main(Algorithm,Problem)
            %% Parameter setting
            [num_infill, epsilon, Gen_max, num_train] = Algorithm.ParameterSet(1, 1e-3, 50, 100);

            %% Initalize the population by Latin hypercube sampling
            if Problem.D < 100
                N      = 100;
            elseif Problem.D >= 100
                N      = 200;
            end
            PopDec     = UniformPoint(N,Problem.D,'Latin');
            Arc        = Problem.Evaluation(repmat(Problem.upper-Problem.lower,N,1).*PopDec+repmat(Problem.lower,N,1));
            Algorithm.NotTerminated(Arc);
            %% Find extreme points
            % Select training sample point
            x_train = Arc.decs;    y_train = Arc.objs;
            % Calculate the kernal width of RBF
            ghxd=real(sqrt(x_train.^2*ones(size(x_train'))+ones(size(x_train))*(x_train').^2-2*x_train*(x_train')));
            D = size(x_train,2);
            spr = max(max(ghxd))/(D*size(x_train,1))^(1/D);
            for i = 1:Problem.M
                % Construct a surrogate for the ith objective
                net = newrbe(x_train',y_train(:,i)',spr);    FUN = @(x) sim(net,x');
                % Locate the optimum of the surrogate model
                max_gen = 20*D; min_error = 1e-4;
                [~,x_extreme,~] = DE(max_gen,FUN,D,Problem.upper,Problem.lower,min_error);
                if min(pdist2(x_extreme,Arc.decs))>epsilon
                    Arc = [Arc,Problem.Evaluation(x_extreme)];
                end
            end
            %% Iterative sampling optimization
            while Algorithm.NotTerminated(Arc)
                % 1: Discriminator-assisted evolutionary exploration
                x_candidates1 = ClassifierSelect(Problem, Arc, N, num_infill);
                if ~isempty(x_candidates1)
                    Choose_index = min(pdist2(x_candidates1,Arc.decs),[],2)>epsilon;
                    if sum(Choose_index)>0
                        Arc = [Arc,Problem.Evaluation(x_candidates1(Choose_index,:))];
                    end
                    if ~Algorithm.NotTerminated(Arc)
                        break;
                    end
                end
                
                % 2: Hypervolume based attention subspace search
                x_candidates2 = Hv_Select(Problem, Arc, N, num_infill, Gen_max, num_train);
                if ~isempty(x_candidates2)
                    Choose_index = min(pdist2(x_candidates2,Arc.decs),[],2)>epsilon;
                    if sum(Choose_index)>0
                        Arc = [Arc,Problem.Evaluation(x_candidates2(Choose_index,:))];
                    end
                    if ~Algorithm.NotTerminated(Arc)
                        break;
                    end
                end
            end
        end
    end
end