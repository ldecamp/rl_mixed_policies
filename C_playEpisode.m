%play an episod when learning/testing composite strategy
function reward=C_playEpisode(map, policy, fixedStart)
    %get global settings
    global blockSize;
    global showUILearning;
    global pRandomAction;
    global pNoCarOnRowTest;
    global N_ACTIONS;

    if nargin==2
        fixedStart=false;
    end

    [sx, sy]=size(map.Grid);
    %define episode length
    episodeLength=sx-1;
    %Update map (generate cars + new start position)
    map=Q_generateMap(map, true, pNoCarOnRowTest, fixedStart);

    %%%%%% For trajectory print %%%%%%%%%
    agentLocation = map.Start;
    realAgentLocation = agentLocation ; % The location on the test map.
    currentMap=map;
    viewableGridMap=map;%set for UI display
    currentTimeStep = 1; %needed for replay
    startingLocation = agentLocation ; % Keeping record of initial location.
    % If you need to keep track of agent movement history:
    agentMovementHistory = zeros(episodeLength+1, 2);
    agentMovementHistory(currentTimeStep, :) = agentLocation;
    %%%%%% End trajectory print %%%%%%%%%

    %display map
    if(showUILearning)
        refreshScreen
        pause(0.05);
    end

    reward=0;
    for i=1:episodeLength
        %retrieve current state
        state=Q_getState(map, agentLocation);
        %do not play epsilon greedy (alway plays policy)
        action=Q_chooseAction(policy, state, agentLocation, 0);
        [rewardSignal, newLocation, currentTimeStep, ...
            agentMovementHistory] = ...
            actionMoveAgent(action, agentLocation, map, ...
                currentTimeStep, agentMovementHistory, pRandomAction);
        %stores accumulated rewards
        reward=reward+rewardSignal;
        %Update Location
        agentLocation=newLocation;
        %display map
        if(showUILearning)
            refreshScreen
            pause(0.05);
        end
    end
    %show full path
    if(showUILearning)
        printAgentTrajectory
        pause(0.05);
    end
end
