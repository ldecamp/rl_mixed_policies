%Return value of the game for the current policy
function gameValue=C_evaluatePolicy(map, policy, nEpisodes)
    %evaluate for X episodes
    for e=1:nEpisodes
        %get reward per episod
        rw=C_playEpisode(map, policy);
        if e==1
            gameValue=rw;
        else
            gameValue=gameValue+rw;
        end
    end
    %get average
    gameValue=gameValue/nEpisodes;
end
