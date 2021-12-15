% parametri della discretizzazione
Tc = 0.01;
method = 'tustin';
% FINE parametri della discretizzazione

% coefficienti PID
Pz = 0.65;
Iz = 0.3;
Dz = 0.35;
Nz = 100;
% FINE coefficienti PID

% ------ PID continuo -----------------------------------------------------
% fdtPznum = Pz;
% fdtPzden = 1;
% 
% fdtIznum = Iz;
% fdtIzden = [1 0];
% 
% fdtDznum = Dz*Nz;
% fdtDzdennum = 1;
% % fdtDzdenden = [1, 0]; % questo mi da 1/s. A me serve 1/(z-1)
% fdtDzden = 1+Nz*tf(fdtDzdennum, fdtDzdenden);
% 
% fdtPz = tf(fdtPznum, fdtPzden);
% fdtIz = tf(fdtIznum, fdtIzden);
% % fdtDz = tf(fdtDznum, fdtDzden);
% fdtDz = Dz*Nz/fdtDzden;
% 
% fdtCtrlz = fdtPz + fdtIz + fdtDz;
% ------ FINE PID continuo ------------------------------------------------

% ------ PID discreto from scratch --------
fdtPZNumDT = Pz;
fdtPZDenDT = 1;

fdtIZNumDT = Iz*Tc;
fdtIzdenDT = [1 -1];

fdtDZNumDT = Dz*Nz;
fdtDZDenNumDT = 1;
fdtDZDenDenDT = [1, -1]; % questo mi da 1/(z-1)
fdtDZDenDT = 1+Nz*Tc*tf(fdtDZDenNumDT, fdtDZDenDenDT, Tc);

fdtPZDT = tf(fdtPZNumDT, fdtPZDenDT, Tc);
fdtIZDT = tf(fdtIZNumDT, fdtIzdenDT, Tc);
fdtDZDT = fdtDZNumDT/fdtDZDenDT;

fdtPIDZDT = fdtPZDT + fdtIZDT + fdtDZDT;
% ------ FINE PID discreto from scratch --------

% ------ discretizzazione PID continuo ---------
fdtCtrlzDisc = c2d(fdtCtrlz, Tc, method);
% ------ FINE discretizzazione PID continuo ---------

% ------ print transfer functions
fdtCtrlzDisc
fdtPIDZDT
% ------ FINE print transfer functions

% - plot step PID discretizzato ---------
figure
step(fdtCtrlzDisc)
legend('PID discretizzato')
% - FINE plot step PID continuo ---------

% - plot step PID discreto from sratch ---------
figure
step(fdtPIDZDT)
legend('PID discreto from sratch')
% - FINE plot step PID continuo ---------