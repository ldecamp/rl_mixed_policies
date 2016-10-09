%Learn optimal policy for scenario where there are no cars on the road
z_initNoCars %init global parameters
saveGraphs=true;
showUILearning=false;
savePolicy=false;
T=15000;

%set baseline for best possible rewards
t=1:T;
maxRewards=4;

exp_rewards=zeros(1, 8);
rewards_hists=zeros(8,T);

delete('Appendix/policies_no_cars.txt');
%train all maps
for m=1:8
    fprintf(['train map ',int2str(m),'\n']);

    % %swap with main loop to replay policies
    % load(['trained/Q',int2str(m),'.mat']);

    %Pick map and define nature reward signals
    currentMap=roadBasisGridMaps(m);
    currentMap.RewardFunction= generateRewardFunction(currentMap, rewards);
    viewableGridMap=currentMap;%set for UI display

    %train for x episodes
    [Q, runRewards]=Q_learning(currentMap, T,1);

    exp_rewards(m)=runRewards(T);
    rewards_hists(m,:)=runRewards;

    if(savePolicy)
        save(['trained/Q',int2str(m),'.mat'],'Q');
    end
    z_savePolicies(Q,m,'Appendix/policies_no_cars.txt');
end

if saveGraphs
    z_savePerformanceQLearning(T, rewards_hists, 'Appendix/perf_no_cars.png');
end

fprintf('training completed... \n');
