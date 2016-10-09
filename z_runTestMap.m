%load initialisation variables (global + initial setup)
z_initMixedStrategies

useTestMap=true;

if(useTestMap)
    map=testMap();
else
    nBasisPerMap=3; %number of minimap to use for test map
    map=randomlyCreateATestGridMapFromMiniMapBlocks( ...
   roadBasisGridMaps, nBasisPerMap, blockSize );
end

%Clear files from previous run
delete('Composite/*');

%get mixed policy for map
[AggtdPolicy, AggtdWeights, CompositePolicies]=C_mixedMap(map);
z_saveMap(map,'Composite/map.txt');

%save output of learnt policy into file
z_savePolicies(AggtdPolicy, 1, 'Composite/overall.txt');
%replay once to see output
fprintf('Evaluating composite policy \n');
rewards=z_replay(map, AggtdPolicy, useTestMap, false, 10000);
fprintf(['game value of current policy is ', num2str(rewards(10000)), '\n']);

fig1=figure(1);
clf(1);
plot(1:10000,rewards);
xlabel('time step');
ylabel('average reward');
title('evolution of average rewards for composite policy');
saveas(fig1, 'Composite/avg_reward.png' ,'png');

%replay once to see output
z_replay(map, AggtdPolicy, useTestMap, true, 1);

cps=length(CompositePolicies);
for cp=1:cps
    CP=CompositePolicies(cp);
    %Plot convergence of weight evolution over time
    fig1=figure(1);
    clf(1);
    plot(1:T,CP.ERewardsHistory);
    axis([0,T,-5,5]);
    xlabel('time step');
    ylabel('average reward');
    title('evolution of average rewards over training timesteps');
    saveas(fig1, ['Composite/perf_evol_section',int2str(cp),'.png'] ,'png');

    %Plot bars comparison
    fig2=figure(2);
    clf(2);
    subplot(1,2,1);
    bar(CP.Weights);
    xlabel('Primitives');
    ylabel('Weight');
    title('Weight assigned to composite policy');
    subplot(1,2,2);
    bar(CP.BasisRewards);
    xlabel('Primitives');
    ylabel('Expected Reward');
    title('Expected reward of primitives for current section');
    saveas(fig2, ['Composite/weights_section',int2str(cp),'.png'] ,'png');
end
