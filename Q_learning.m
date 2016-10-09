%execute Q learning procedure
function [Q, rewards]=Q_learning(map, T, nStates, Q)
    %get global settings
    global mapSize;
    global N_ACTIONS;
    global initialQValue;
    global pNoCarOnRowTest;
    global showProgress;
    global execLearning;

    %generate distribution for Pno Car when learning
    distrib=0.1*ones(1,8);
    distrib(8)=0.3;
    pNoCarValues=0.1:0.1:0.8;

    %if Q not passed initialises otherwise use one provided
    if nargin == 3
        Q=initialQValue*ones(mapSize,mapSize,nStates,N_ACTIONS);
    end

    %stores average rewards per episod (based on testing)
    rewards=zeros(T,1);

    acc_rewards=0; %define current episod reward
    for t=1:T
        %display progress indicator
        if (showProgress & mod(t/T,0.01)==0)
            fprintf(['training progress : ',num2str(t/T),'\n']);
        end

        if(execLearning)
            pNoCarTrain=pNoCarOnRowTest;
            if(nStates>1)
                %generate random car probability based on non uniform distribution.
                pNoCarTrain=datasample(pNoCarValues,1,'Weights',distrib);
            end
            %train
            trainmap=Q_generateMap(map,nStates>1,pNoCarTrain);
            %epsilon to 1 to always pick up random action
            [Q, trainRewards]=Q_playEpisode(trainmap,Q,nStates,1);
        end

        %evaluate
        testmap=Q_generateMap(map,nStates>1,pNoCarOnRowTest);
        %always test with best policy
        [tQ,testRewards]=Q_playEpisode(testmap,Q,nStates,0);
        acc_rewards=acc_rewards+testRewards;
        %store rewards for episod
        rewards(t)=acc_rewards/t;
    end
end
