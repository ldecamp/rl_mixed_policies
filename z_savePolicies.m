%Save policies into file
function z_savePolicies(Q,m,filepath)
    fileID = fopen(filepath(:),'a');

    %if first map print legend before
    if(m==1)
        fprintf(fileID,'legend: \n');
        fprintf(fileID,'#: action is indifferent (Q values equal for all state, action pairs) \n');
        fprintf(fileID,'?: 2 actions have equal weights \n');
        fprintf(fileID,'\\: best action is to go left \n');
        fprintf(fileID,'|: best action is to go forward \n');
        fprintf(fileID,'/: best action is to go right \n\n');
    end
    fprintf(fileID,['Policies for map ', int2str(m), '\n']);

    si=size(Q);
    %print for all states
    %print \ if best action is left | if center and / if right
    for state=1:si(3)

        if(state==1)
            fprintf(fileID,'learnt policy when no car is ahead. \n');
        elseif(state==2)
            fprintf(fileID,'learnt policy when a car is on the upper left tile. \n');
        elseif(state==3)
            fprintf(fileID,'learnt policy when a car is on the upper front tile. \n');
        else
            fprintf(fileID,'learnt policy when a car is on the upper right tile. \n');
        end

        for i=1:si(1) %print for each row
            for j=1:si(2) %print for each column
                %get best action
                [mx, action]=max(Q(i,j,state,:));
                if(length(find(Q(i,j,state,:)==mx))==3)
                    fprintf(fileID,'# ');
                elseif(length(find(Q(i,j,state,:)==mx))==2)
                    fprintf(fileID,'? ');
                elseif(action==1)
                    fprintf(fileID,'\\ ');
                elseif(action==2)
                    fprintf(fileID,'| ');
                else
                    fprintf(fileID,'/ ');
                end
            end
            fprintf(fileID,'\n');
        end
        fprintf(fileID,'\n');
    end
    fclose(fileID);
end
