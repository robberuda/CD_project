%[y,z,t]
WayPts = [[0,0,1];
          [0,-1,2];
          [0,-1,6];
          %[-1,-4,10];
          %[2,-1,14];
          %[1,-5.5,18];
          %[0,-1,22];
          %[0,-9,24];
          %[4,-7,37];
          %[-2,-3,42];
          %[-3,-6,47];
          %[-1,-7,52]
          ]
      
dY = []
dZ = []

for i = 1:length(WayPts)-2
    dY(i) = (WayPts(i+2,1)-WayPts(i+1,1))/(WayPts(i+2,3)-WayPts(i+1,3))
    dZ(i) = (WayPts(i+2,2)-WayPts(i+1,2))/(WayPts(i+2,3)-WayPts(i+1,3))
end

Tfinal = 30;
TOFtime = 1
ts = 0.1
t = 0:ts:Tfinal

% Superpose signals
z_sum = 0*t
y_sum = 0*t
for k = 1:length(WayPts)
    if k == 1
        section = [0, WayPts(k,3)];
        start_section = section(1);
        end_section = section(2);
        
        for i = 1:length(z_sum)
            if t(i) >= start_section && t(i) <= end_section
                z_sum(i) = 0;
                y_sum(i) = 0;
            end
        end
        
    elseif k == 2
        section = [WayPts(k-1,3),WayPts(k,3)]
        start_section = section(1);
        end_section = section(2);
        
        for i = 1:length(z_sum)
            if t(i) > start_section && t(i) <= end_section
                z_sum(i) = -1;
                y_sum(i) = 0;
            end
        end
        
    else
        section = [WayPts(k-1,3),WayPts(k,3)]
        start_section = section(1);
        end_section = section(2);
        
        for i = 1:length(z_sum)            
            if t(i) > start_section && t(i) <= end_section
                z_sum(i) = z_sum(i-1) + ts*dZ(k-2);
                y_sum(i) = y_sum(i-1) + ts*dY(k-2);
            end
        end
        
    end
end

start_section = WayPts(length(WayPts),3)
end_section = Tfinal
for i = 1:length(z_sum)
    if t(i) > start_section && t(i) <= end_section
        z_sum(i) = z_sum(i-1)
        y_sum(i) = y_sum(i-1)
    end
end

% Generate timeseries cmd
sigZ = [t;z_sum]
Zcmd = timeseries(sigZ(2:end,:),sigZ(1,:))
sigY = [t;y_sum]
Ycmd = timeseries(sigY(2:end,:),sigY(1,:))

clear section
clear start_section
clear end_section
clear y_sum
clear z_sum
clear i
clear k
