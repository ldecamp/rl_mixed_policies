%learn mixed strategy from set of basis for new map
%mixed strategy is learn row by row until last block is reached
function [AggtdPolicy, AggtdWeights, CompositePolicies]=C_mixedMap(map)
    global blockSize;
    global N_ACTIONS;
    global N_STATES;
    global N_POLICIES;
    global T;
    global showProgress;

    [sx,sy]=size(map.Grid);
    nblocks=sx-blockSize;

    policies=zeros(nblocks, blockSize, blockSize, N_STATES, N_ACTIONS);
    weights=zeros(nblocks, N_POLICIES);

    combined_policy=zeros(sx, sy, N_STATES, N_ACTIONS);
    combined_weights=zeros(sx, N_POLICIES);

    %stores evolution of weights and expected rewards over time
    stats=zeros(nblocks, T, N_POLICIES);
    ex_rewards=zeros(nblocks, T);

    %load primitives strategies
    basis=C_loadBasis();
    %get starting location of current map (this is purely arbitraty and only serve to extract section to get mixed strategy from)
    mapLocation = map.Start;

    %go through map 1 block at a time
    for i=0:nblocks
        mapLocation=[sx-i, 3];
        fprintf(['Computing mixed policy for location: ',int2str(mapLocation(1)),'\n']);

        %get current section
        section = setCurrentViewableGridMap(map, mapLocation, blockSize);

        %learn composite strategy for current section
        CP=C_mixedSection(section, basis);

        fprintf(['Updating overall policy mix: ',int2str(i),'\n']);
        %update combined policy and weights
        for y=1:blockSize
            zz=mapLocation(1)-y+1;
            combined_policy(zz,:,:,:)=CP.Policy(blockSize-y+1,:,:,:);
            combined_weights(zz,:)=CP.Weights;
        end

        CompositePolicies(i+1)=CP;

        %plot expected reward evolution for current map
        if(showProgress)
            figure(1);
            plot(1:T,CP.ERewardsHistory);
            figure(2);
            bar(1:N_POLICIES,CP.Weights);
            figure(3);
            bar(1:N_POLICIES,CP.BasisRewards);
            drawnow
        end

        %if comes to last block exit as computed in one shot
        %i.e. map do not change anymore afterwards
        if(mapLocation(1)==blockSize)
            break;
        end
    end
    AggtdPolicy=combined_policy;
    AggtdWeights=combined_weights;
end
