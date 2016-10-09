function [ rewardFunction ] = generateRewardFunction( GridMap, rewards )
%GENERATEREWARDFUNCTION The reward function for this experiment is only
%state dependent. This function will generate a matrix of dimensions
%size(GridMap.Grid), populated with the respective reward values for each
%state, and append it to the GridMap object.
    
    rewardFunction = ...
        ( 1 - GridMap.Grid ) * rewards(1) + ... paved square
        GridMap.Grid * rewards(2) + ... non-paved square
        GridMap.CarLocations * (rewards(3) - rewards(1)) ; % car collisions
    
end

