%Replay function to either play policy on screen using Show UI or compute expected reward of policy
function rewards=z_replay(map, policy, fixedStart, showUI, nEpisodes)
    figure(1);
    global showUILearning;
    showUILearning=showUI;
    rewards=zeros(1,nEpisodes);
    r=0;
    for e=1:nEpisodes
        r=r+C_playEpisode(map, policy, fixedStart);
        rewards(e)=r/e;
    end
    showUILearning=false;
end
