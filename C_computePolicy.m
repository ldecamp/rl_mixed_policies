%Compute the composite policy using current weights and basis (weighted sum)
function policy=C_computePolicy(mapSize, basis, weights)
    [N_basis, sx, sy, NSTATES, NACTIONS]=size(basis);
    policy=zeros(mapSize(1), mapSize(2), NSTATES, NACTIONS);

    %weighted sum of basis Q values
    for b=1:N_basis
        w=weights(b);
        bs=reshape(basis(b,:,:,:,:), [sx, sy, NSTATES, NACTIONS]);
        policy=policy+w*bs;
    end
end
