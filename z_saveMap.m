%Save generated map to a file
function z_saveMap(map, filepath)
    delete(filepath(:));
    fileID = fopen(filepath(:),'a');

    fprintf(fileID,'legend: \n');
    fprintf(fileID,'$: paved road \n');
    fprintf(fileID,'C: car \n');
    fprintf(fileID,'!: grass \n\n');

    [sx, sy]=size(map.Grid);

    for i=1:sx
        for j=1:sy
            if(map.Grid(i,j)==1) %grass
                fprintf(fileID,'! ');
            elseif(map.hasCars() && map.CarLocations(x,y)==1) %cars on the road
                fprintf(fileID,'C ');
            else
                fprintf(fileID,'£ ');
            end
        end
        fprintf(fileID,'\n');
    end
    fclose(fileID);
end
