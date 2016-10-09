% Learn composite policies from set of basis policies
% Based on algorithm detailed in paper
% Input is section to learn composite policies for (Should be same size as basis)
% Output is The policy learnt, the weight of each basis and some stats
function CP=C_mixedSection(section, basis)
    %load bunch of constants
    global T;
    global N_POLICIES;
    global N_EvalEpisodes;
    global N_EvalBasisEpisodes;

    ms=size(section.Grid);
    [N_basis, sx, sy, NSTATES, NACTIONS]=size(basis);

    %check prerequisite (learn on block of same size as basis)
    if(ms(1)~=sx & ms(2)~=sy)
        fprintf('Error map size does not match size of basis \n');
        return;
    end

    %get beta constant
    N = N_POLICIES;
    beta = 1/(1+sqrt(2*log(N)/T));

    %store evolution of W over time
    whist=zeros(T, N);
    e_rewards=zeros(1,T);

    %compute game value for basis
    RewardBasis=zeros(1,N);
    for b=1:N
        bpol=reshape(basis(b,:,:,:,:),[sx, sy, NSTATES, NACTIONS]);
        RewardBasis(b)=C_evaluatePolicy(section, bpol, N_EvalBasisEpisodes);
        fprintf(['Expected reward from basis ', int2str(b), ' is ',num2str(RewardBasis(b)),'\n']);
    end

    %initialise weights (to get a value of mixed policies per position in map)
    W=(1/N)*ones(1,N);
    for t=1:T
        %Update game policy
        policy=C_computePolicy(ms, basis, W);

        % Evaluate policy performance
        game_value=C_evaluatePolicy(section, policy, N_EvalEpisodes);
        %store stats
        e_rewards(t)=game_value;

        %Compute new G
        G=(repmat(game_value, [1 N])-RewardBasis+1)/2;
        pow=beta.^G;
        %update weights and normalise
        W=W.*pow;
        W=W./sum(W);
        whist(t,:)=W;
    end
    CP=CompositePolicy(policy, W, RewardBasis, e_rewards, whist, section);
end
