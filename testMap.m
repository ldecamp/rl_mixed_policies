function [gridMap] = testMap ( )
% Test map for HW2

% frame
grid = ...
    [ ...
    1 0 0 1 1 ; ...
    1 0 0 1 1 ; ...
    1 0 1 1 1 ;...
    0 0 1 0 1 ;...
    1 0 0 1 1 ;...
    1 0 0 0 1 ;...
    0 0 0 0 0 ;...
    0 0 1 0 1 ;...
    0 0 1 0 0 ;...
    0 0 0 0 1 ;...
    0 0 0 1 0 ;...
    1 1 0 1 0 ;...
    1 1 0 1 0 ;...
    1 0 0 1 0 ;...
    0 0 1 1 0 ;...
    ] ;

% start location (for when necessary)
start = [15, 5] ;

markerRescaleFactor = 5* 1/( (25^2)/36 ) ;

gridMap = GridMap(grid, start, markerRescaleFactor) ;