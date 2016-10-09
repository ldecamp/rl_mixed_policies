% Print obstacle cars:
if size( currentMap.CarLocations, 1 ) > 1
    [ rows, columns ] = ...
        find( currentMap.CarLocations ) ;

    arrayOfCarLocations = [ rows , columns ] ;

    printAgentLocation( currentMap, 5, arrayOfCarLocations, ...
        currentMap.MarkerRescaleFactor, 'd' ) ;

end % if car locations have been generated for the currently activated map
