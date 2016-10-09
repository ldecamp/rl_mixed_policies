classdef CompositePolicy
%C_stats: store all stats for one section of composed map
    properties
        Policy
        Weights %final weights
        BasisRewards %expected rewards of basis policies
        ERewardsHistory %evolution of expected rewards over training
        WeightsHistory %evolution of weights over training
        Map
    end

    methods % Ctor
        function Pol=CompositePolicy(policy, weights, basisRewards, ExpRewardsHistory, weightsHistory, map)
            Pol.Policy=policy;
            Pol.Weights=weights;
            Pol.BasisRewards=basisRewards;
            Pol.ERewardsHistory=ExpRewardsHistory;
            Pol.WeightsHistory=weightsHistory;
            if nargin==6
                Pol.Map=map;
            end
        end
    end
end
