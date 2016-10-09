%load Policies from primitives
function basis=C_loadBasis()
    global blockSize;
    global N_STATES;
    global N_ACTIONS;
    global N_POLICIES;

    basis=zeros(N_POLICIES,blockSize,blockSize,N_STATES,N_ACTIONS);
    for m=1:N_POLICIES
        load(['trained/Qcars',int2str(m),'.mat']);
        basis(m,:,:,:,:)=Q;
    end
end
