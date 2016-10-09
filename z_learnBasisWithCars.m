%Learn optimal policy for scenario where there are no cars on the road
z_initWithCars %init global parameters
showUILearning=false;
saveGraphs=false;
savePolicy=true;

T=35000;
%set baseline for best possible rewards
t=1:T;
maxRewards=4;

exp_rewards=zeros(1, 8);
rewards_hists=zeros(8,T);

delete('Appendix/policies_cars.txt');

%train all maps
for m=1:8
    fprintf(['train map ',int2str(m),'\n']);

    % % load learnt matrices to replay policies
    % load(['trained/Qcars',int2str(m),'.mat']);

    %Pick map and define nature reward signals
    currentMap=roadBasisGridMaps(m);
    viewableGridMap=currentMap;%set for UI display
    %train for x episodes
    [Q, runRewards]=Q_learning(currentMap, T,4);
    exp_rewards(m)=runRewards(T);
    rewards_hists(m,:)=runRewards;

    if(savePolicy)
        save(['trained/Qcars',int2str(m),'.mat'],'Q');
    end
    z_savePolicies(Q,m,'Appendix/policies_cars.txt');
end

if saveGraphs
    z_savePerformanceQLearning(T, rewards_hists, 'Appendix/perf_cars.png');
end

fprintf('training completed... \n');
