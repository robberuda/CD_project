%set workspace

%% Setup Drone
m = 0.2;
I = 0.1;

% sample time
ts = 0.01;

% Initial States 
Becc_0 = 0;

% Start position 
XY_0 = [1;1];
%body_rate_0 = [0;0;0]

% Environment
g = -9.81;


WayPts = [[0,0,1];
          [0,-1,2];
          [3,-4,6];
          [-1,-4,10];
          [2,-1,14];
          [1,-5.5,18];
          [0,-1,22];
          ]


% Target position
z_target = 2;
y_target = 2;

%liftoff or takeoff time
TOFtime = 1;




