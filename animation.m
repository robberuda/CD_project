%animation of drone
d = 0.2;

i=1;
for t=1:tss:Tfinal;  
    x = P(i,1);
    y = P(i,2);
    
    d1x = x - cos(P(i,3));
    d1y = y - sin(P(i,3));
    d2x = x + cos(P(i,3));
    d2y = y + sin(P(i,3));
    
    plot([d1x d1y],[d2x d2y],P(:,1),P(:,2),x,y,'s','MarkerSize',15,'MarkerFaceColor','R','MarkerEdgeColor','R');
    %plot([d1x d1y],[d2x d2y]);
    ylim([-5,5]);
    xlim([-5,5]);
    anim(i)=getframe;
    i=i+1;
end

clear i;
    