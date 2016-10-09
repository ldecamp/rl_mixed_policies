classdef GridMap
%GRIDMAP: Stores data for a 2D grid-map, as well as the agent's start
%location along with the $CarLocations$ and the $RewardFunction$. The grid
%is assumed to take values of "0:paved and 1:non-paved".
%
    properties
        Grid
        Start
        MarkerRescaleFactor
        Size
        CarLocations
        RewardFunction
    end % properties

    methods
        function GM = GridMap(grid, start, markerRescaleFactor)
            if nargin < 3
                markerRescaleFactor = 1 ;
            end
            GM.MarkerRescaleFactor = markerRescaleFactor ;
            GM.Grid = grid ;
            [ GM.Size, ~ ] = size(grid) ;
            if nargin > 1
                GM.Start = start ;
            end
            GM.CarLocations = 0 ;
            GM.RewardFunction = 0 ;
        end % GridMap
    end

    methods(Access=public)
        function hc = hasCars(obj)
            [mx,my]=size(obj.Grid);
            [cx,cy]=size(obj.CarLocations);
            hc=mx==cx&&my==cy;
        end
        function hr = hasRewards(obj)
            [mx,my]=size(obj.Grid);
            [rx,ry]=size(obj.RewardFunction);
            hr=mx==rx&&my==ry;
        end
    end % methods

end % classdef
