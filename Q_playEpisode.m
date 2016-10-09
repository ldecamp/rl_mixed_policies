%Play a learning episode using Q learning
function [Q,rewardCollected]=Q_playEpisode(map,Q,nStates,epsilon)
    %get global settings
    global mapSize;
    global showUILearning;
    global learningRate;
    global discountFactor;
    global pRandomAction;
    global N_ACTIONS;

    %define episode length
    episodeLength=mapSize-1;
    agentLocation = map.Start;

    %%%%%% For trajectory print %%%%%%%%%
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

    rewardCollected=0;
    for i=1:episodeLength
        %retrieve current state (when no car always 1)
        if(nStates==1)
            state=1;
        else
            state=Q_getState(map, agentLocation);
        end

        %choose best action
        action=Q_chooseAction(Q, state, agentLocation, epsilon);

        [rewardSignal, newLocation, currentTimeStep, ...
            agentMovementHistory] = ...
            actionMoveAgent(action, agentLocation, map, ...
                currentTimeStep, agentMovementHistory, pRandomAction);

        x=agentLocation(1);
        y=agentLocation(2);
        %Update Q Value
        Q_sa = Q(x, y, state, action);

        if(nStates==1)
            nstate=1;
        else
            nstate=Q_getState(map, newLocation);
        end
        Qval_next=max(Q(newLocation(1), newLocation(2), nstate, :));
        Q_nsa = discountFactor*Qval_next;
        Q(x, y, state, action)=Q_sa+learningRate*(rewardSignal+Q_nsa-Q_sa);

        %stores accumulated rewards
        rewardCollected=rewardCollected+rewardSignal;
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
