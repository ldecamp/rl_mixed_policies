%Get the current for the environment
% state 1: No car visible in nearby tiles (horizon 1)
% state 2: car visible on left tile
% state 3: car visible on front tile
% state 4: car visible on right tile
function state=Q_getState(map, position)
    global mapSize;
    x=position(1)-1;
    y=position(2);

    state=1; %default no cars
    if(x<1) %if last row return
        return;
    end
    if(y>1) %if can check on left
        if(map.CarLocations(x,y-1)==1)
            state=2;
            return;
        end
    end

    if(y<mapSize) %if can check on right
        if(map.CarLocations(x,y+1)==1)
            state=4;
            return;
        end
    end

    if(map.CarLocations(x,y)==1)
        state=3;
    end
end
