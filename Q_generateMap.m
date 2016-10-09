%Generate cars, start location and assign reward to the map
function map=Q_generateMap(map, hasCars, pNoCarOnRow, fixedStart)
    if nargin==3
        fixedStart=false;
    end

    global actionsRewards;
    [sx, sy]=size(map.Grid);

    if(fixedStart==false)
        %set start position at random
        map.Start=[sx,randi(sy)];
    end
    if(hasCars) %generate new cars and update rewards
        map.CarLocations = populateWithCars(map.Grid, pNoCarOnRow);
        map.RewardFunction= generateRewardFunction(map, actionsRewards);
    end
end
