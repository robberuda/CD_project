% parametri della discretizzazione
Tcamp = 0.01;
method = 'zoh';
% FINE parametri della discretizzazione

% coefficienti PID
Pz = 0.65;
Iz = 0.3;
Dz = 0.35;
Nz = 100;
% FINE coefficienti PID

PID_DT_Z = coomputeDT_PID_TF(Pz, Iz, Dz, Nz, Tc);

% ------ PID discreto from scratch --------
function fdtPIDZDT = coomputeDT_PID_TF(P, I, D, N, Ts)
    fdtPZNumDT = P;
    fdtPZDenDT = 1;

    fdtIZNumDT = I*Ts;
    fdtIzdenDT = [1 -1];

    fdtDZNumDT = D*N;
    fdtDZDenNumDT = 1;
    fdtDZDenDenDT = [1, -1]; % questo mi da 1/(z-1)
    fdtDZDenDT = 1+N*Ts*tf(fdtDZDenNumDT, fdtDZDenDenDT, Ts);

    fdtPZDT = tf(fdtPZNumDT, fdtPZDenDT, Ts);
    fdtIZDT = tf(fdtIZNumDT, fdtIzdenDT, Ts);
    fdtDZDT = fdtDZNumDT/fdtDZDenDT;

    fdtPIDZDT = fdtPZDT + fdtIZDT + fdtDZDT;
end
% ------ FINE PID discreto from scratch --------

