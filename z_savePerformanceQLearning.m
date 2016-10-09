%save performance graph into file for report
function z_savePerformanceQLearning(T, rewards, filepath)
    colours=[[.7 .7 .7]; [1 0 1]; [1,0.4,0.6]; ...
         [1 0 0]; [0 1 0.2]; [0 0 1]; [0 0 0]; [0.5 0.5 1]];
    %print average reward over training
    fig=figure(2);
    clf(2);
    for m=1:8
        hold on;
        mp=plot(t, rewards(m,:));
        set(mp,'Color',colours(m,:)),;
        xlabel('episode');
        ylabel('average reward');
        title('evolution of average rewards over episodes');
        axis([0,T,-2,5]);
        hold off;
    end
    legend('primitive 1','primitive 2', 'primitive 3', 'primitive 4', 'primitive 5', 'primitive 6', 'primitive 7', 'primitive 8','Location','southeast');
    saveas(fig, filepath(:) ,'png');
end
