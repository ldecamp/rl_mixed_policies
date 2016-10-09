%Pick up next action based on an E-greedy policy
function action=Q_chooseAction(Q, state, location, epsilon)
    %retrieve some global settings
    global mapSize;
    global N_ACTIONS;

    %use epsilon greedy method to select action
    %if more than threshold exec random action otherwise use max Q
    randAction=rand();
    if(randAction<epsilon)
        action=randi(N_ACTIONS);
        return;
    end
    %find action that maximises rewards
    q_values=Q(location(1), location(2), state, :);

    m=max(q_values);
    actions=find(q_values==m);
    %if several actions have the same probability randomly pick one
    if(length(actions)==3)
        ind=randi(3);
    elseif(length(actions)==2)
        ind=randi(2);
    else
        ind=1;
    end
    action=actions(ind);
end
