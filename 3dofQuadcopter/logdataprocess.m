t_get = 0;
ilist = [];
for i = 1:length(out.tout)
    if abs(out.tout(i) - t_get) < 0.0001
        disp("equal!!!!")
        ilist(length(ilist)+1) = i
        t_get = t_get + ts
    end
end
t_plot = []
y_plot = []
z_plot = []
roll_plot = []
for j = 1:length(ilist)
    t_plot(length(t_plot)+1) = out.tout(ilist(j))
    y_plot(length(y_plot)+1) = out.yout(ilist(j))
    z_plot(length(z_plot)+1) = out.zout(ilist(j))
    roll_plot(length(roll_plot)+1) = out.rollout(ilist(j))
end
z_plot = z_plot*-1

clear j
clear i
clear t_get