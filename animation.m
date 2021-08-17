y_plot = P(:,1);
z_plot = P(:,2);
roll_plot = P(:,3);
t_plot = P(:,4);

figure;
curve = animatedline('LineWidth',0.5);
curver = animatedline('LineWidth',0.1,'LineStyle',':');
curvel = animatedline('LineWidth',0.1,'LineStyle',':');

set(gca, 'XLim', [-1.0,1.0],'YLim',[-5 5],'ZLim',[-5 5]);
view(90,0)
hold on;
grid on;

x_plot = 0*t_plot

bar = 1;

yr_plot = y_plot + bar*cos(roll_plot)
yl_plot = y_plot - bar*cos(roll_plot)
zr_plot = z_plot - bar*sin(roll_plot)
zl_plot = z_plot + bar*sin(roll_plot)

n = length(t_plot)
for i = 1:n
    addpoints(curve, x_plot(i), y_plot(i), z_plot(i));
    addpoints(curver, x_plot(i), yr_plot(i), zr_plot(i));
    addpoints(curvel, x_plot(i), yl_plot(i), zl_plot(i));
    head = scatter3(x_plot(i), y_plot(i), z_plot(i),'filled','MarkerFaceColor','b','MarkerEdgeColor','b')
    headr = scatter3(x_plot(i), yr_plot(i), zr_plot(i),'filled','MarkerFaceColor','r','MarkerEdgeColor','r')
    headl = scatter3(x_plot(i), yl_plot(i), zl_plot(i),'filled','MarkerFaceColor','r','MarkerEdgeColor','r')

    % Their vertial concatenation is what you want
    pts = [ [0,yl_plot(i),zl_plot(i)]; [0,yr_plot(i),zr_plot(i)] ];

    % Alternatively, you could use plot3:
    frame = plot3(pts(:,1), pts(:,2), pts(:,3),'b');
    
    drawnow;
    %pause(ts);
    
    delete(head);
    delete(headr);
    delete(headl);
    delete(frame);
    
end

clear n;
clear pts;
clear curve;
clear curver;
clear curvel;

clear x_plot;
clear y_plot;
clear yl_plot;
clear yr_plot;
clear z_plot;
clear zl_plot;
clear zr_plot;
clear roll_plot;
clear i;
clear ilist;
clear frame;
clear head;
clear headl;
clear headr;