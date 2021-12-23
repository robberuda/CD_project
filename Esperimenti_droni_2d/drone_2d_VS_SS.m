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

%% conversione da modello VS a TF
[az, bz] = ss2tf(Az, Bz, Cz, Dz);
[ag, bg] = ss2tf(Ag, Bg, Cg, Dg);
[at, bt] = ss2tf(At, Bt, Ct, Dt);
[ay, by] = ss2tf(Ay, By, Cy, Dy);

%% generazione modello MIMO
maxOrdDeriv = 2;
mz = zeros(maxOrdDeriv); % matrice di zeri
A = [Az mz mz; ...
     mz Ay mz; ...
     mz mz At];
B = [ 0    0 0   0   ;
      -1/m 1 0   0   ;
      0    0 0   0   ;
      0    0 0   1/m ;
      0    0 0   0   ;
      0    0 1/i 0   ];
C = [ 1 0 0   0 0 0 ;
      0 0 1   0 0 0 ;
      0 0 0   0 1 0 ];
D = zeros(3, 4);

% [b,a] = ss2tf(A,B,C,D) % funziona solo per modelli SISO