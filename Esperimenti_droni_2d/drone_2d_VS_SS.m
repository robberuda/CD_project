%% parametri del modello fisico

m = 0.2; % massa
i = 0.1; % momento d'inerzia
g = 9.81; % accelerazione di gravità

%% matrici plant z, dato F
Az = [ 0 1; 0 0];
Bz = [ 0 -1/m ]';
Cz = [ 1 0 ];
Dz = [ 0 ];

%% matrici plant z, dato g
Ag = [ 0 1; 0 0];
Bg = [ 0 1 ]';
Cg = [ 1 0 ];
Dg = [ 0 ];

%% matrici palnt theta
At = [ 0 1; 0 0];
Bt = [ 0 1 ]';
Ct = [ 1 0 ];
Dt = [ 0 ];

%% matrici plant y
Ay = [ 0 1; 0 0];
By = [ 0 1/m ]';
Cy = [ 1 0 ];
Dy = [ 0 ];

%% generazione modelli in variabili di stato VS
vsz = ss(Az, Bz, Cz, Dz);
vsg = ss(Ag, Bg, Cg, Dg);
vst = ss(At, Bt, Ct, Dt);
vsy = ss(Ay, By, Cy, Dy);