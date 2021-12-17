% Nope, non possono essere sommate così; posso però sommare le loro uscite
% fdt_z = fdt_in + fdt_g;


% parametri del modello fisico

m = 0.2; % massa
i = 0.1; % momento d'inerzia
g = 9.81; % accelerazione di gravità


% parametri della discretizzazione

Tc = 0.01;
method = 'zoh';

% -------------------------------------------------------------------------
% 1 - Funzione di trasferimento sistema evoluzione lungo z

plantZNum = 1/m;
plantZDen = [1 0 0];

fdtPlantZ = tf(plantZNum, plantZDen);
fdt_g = tf(1, plantZDen);

Pz = 0.65;
Iz = 0.3;
Dz = 0.35;
Nz = 100;

fdtPznum = Pz;
fdtPzden = 1;

fdtIznum = Iz;
fdtIzden = [1 0];

fdtDznum = Dz*Nz;
fdtDzdennum = 1;
fdtDzdenden = [1, 0]; % questo mi da 1/s
fdtDzden = 1+Nz*tf(fdtDzdennum, fdtDzdenden);

fdtPz = tf(fdtPznum, fdtPzden);
fdtIz = tf(fdtIznum, fdtIzden);
% fdtDz = tf(fdtDznum, fdtDzden);
fdtDz = fdtDznum/fdtDzden;

fdtCtrlz = fdtPz + fdtIz + fdtDz;

fdtPlantCtrlz = fdtPlantZ*fdtCtrlz;
% fdtClosedLoopz = fdtPlantCtrlz/( 1 + fdtPlantCtrlz ) %???????????????
fdtClosedLoopz = feedback(fdtPlantCtrlz, 1);
% --- FINE - 1 - Funzione di trasferimento sistema evoluzione lungo z -----


% -------------------------------------------------------------------------
% 2 - Funzione di trasferimento sistema evoluzione lungo t

% t is for theta

planttNum = 1/i;
planttDen = [1 0 0];

fdtPlantt = tf(planttNum, planttDen);

Pt = 0.6;
It = 0;
Dt = 0.7;
Nt = 100;

fdtPtnum = Pt;
fdtPtden = 1;

fdtItnum = It;
fdtItden = [1 0];

fdtDtnum = Dt*Nt;
fdtDtdennum = 1;
fdtDtdenden = [1, 0];
fdtDtden = 1+Nt*tf(fdtDtdennum, fdtDtdenden);

fdtPt = tf(fdtPtnum, fdtPtden);
fdtIt = tf(fdtItnum, fdtItden);
% fdtDt = tf(fdtDtnum, fdtDtden);
fdtDt = Dt*Nt/fdtDtden;

fdtCtrlt = fdtPt + fdtIt + fdtDt;

fdtPlantCtrlt = fdtPlantt*fdtCtrlt;
% fdtClosedLoopt = fdtPlantCtrlt/( 1 + fdtPlantCtrlt ) % ???????????????
fdtClosedLoopt = feedback(fdtPlantCtrlt, 1);
% --- FINE - 2 - Funzione di trasferimento sistema evoluzione lungo t -----



% -------------------------------------------------------------------------
% 3 - Funzione di trasferimento sistema evoluzione lungo y

plantyNum = 1/m;
plantyDen = [1 0 0];

fdtPlanty = tf(plantyNum, plantyDen);

Py = 0.5;
Iy = 0;
Dy = 0.4;
Ny = 100;

fdtPynum = Py;
fdtPyden = 1;

fdtIynum = Iy;
fdtIyden = [1 0];

fdtDynum = Dy*Ny;
fdtDydennum = 1;
fdtDydenden = [1, 0];
fdtDyden = 1+Ny*tf(fdtDydennum, fdtDydenden);

fdtPy = tf(fdtPynum, fdtPyden);
fdtIy = tf(fdtIynum, fdtIyden);
% fdtDy = tf(fdtDynum, fdtDyden);
fdtDy = Dy*Ny/fdtDyden;

fdtCtrly = fdtPy + fdtIy + fdtDy;

fdtPlantCtrly = fdtPlanty*fdtCtrly*fdtClosedLoopt;
% fdtClosedLoopy = fdtPlantCtrly/( 1 + fdtPlantCtrly ) %???????????????
fdtClosedLoopy = feedback(fdtPlantCtrly, 1);
% --- FINE - 3 - Funzione di trasferimento sistema evoluzione lungo y -----


% ------------------ discretization ---------------------------------------
fdtPlantZDisc = c2d(fdtPlantZ, Tc, method);
fdtPlantyDisc = c2d(fdtPlanty, Tc, method);
fdtClosedLoopzDisc = c2d(fdtClosedLoopz, Tc, method);
fdtClosedLooptDisc = c2d(fdtClosedLoopt, Tc, method);
fdtClosedLoopyDisc = c2d(fdtClosedLoopy, Tc, method);
% ------------------ end discretization -----------------------------------

% ------------------ PRINT SYSTEMS ----------------------------------------
fdtPlantZ
fdtPlanty
fdtClosedLoopz
fdtClosedLoopt
fdtClosedLoopy

fdtPlantZDisc
fdtPlantyDisc
fdtClosedLoopzDisc
fdtClosedLooptDisc
fdtClosedLoopyDisc
% ------------------ END PRINT SYSTEMS-------------------------------------

% ----------------- CHECK STABILITÀ CONTINUI ------------------------------
disp("Is fdtPlantZ stable?")
disp( isstable(fdtPlantZ) )

disp("Is fdtPlanty stable?")
disp( isstable(fdtPlanty) )

disp("Is fdtClosedLoopz stable?")
disp( isstable(fdtClosedLoopz) )

disp("Is fdtClosedLoopt stable?")
disp( isstable(fdtClosedLoopt) )

disp("Is fdtClosedLoopy stable?")
disp( isstable(fdtClosedLoopy) )
% ----------------- FINE CHECK STABILITÀ CONTINUI -------------------------

% ----------------- CHECK STABILITÀ DISCRETI ------------------------------
disp("Is fdtPlantZDisc stable?")
disp( isstable(fdtPlantZDisc) )

disp("Is fdtPlantyDisc stable?")
disp( isstable(fdtPlantyDisc) )

disp("Is fdtClosedLoopzDisc stable?")
disp( isstable(fdtClosedLoopzDisc) )

disp("Is fdtClosedLooptDisc stable?")
disp( isstable(fdtClosedLooptDisc) )

disp("Is fdtClosedLoopyDisc stable?")
disp( isstable(fdtClosedLoopyDisc) )
% ----------------- FINE CHECK STABILITÀ DISCRETI -------------------------

% ----------------- CALCOLO POLI CONTINUI ---------------------------------
polesZPlant = pole(fdtPlantZ)
polesYPlant = pole(fdtPlanty)
polesZClosedLoop = pole(fdtClosedLoopz)
polesTClosedLoop = pole(fdtClosedLoopt)
polesYClosedLoop = pole(fdtClosedLoopy)
% ----------------- FINE CALCOLO POLI CONTINUI ----------------------------

% ----------------- CALCOLO POLI DISCRETI ---------------------------------
polesZPlantD = pole(fdtPlantZDisc)
polesYPlantD = pole(fdtPlantyDisc)
polesZClosedLoopD = pole(fdtClosedLoopzDisc)
polesTClosedLoopD = pole(fdtClosedLooptDisc)
polesYClosedLoopD = pole(fdtClosedLoopyDisc)
% ----------------- FINE CALCOLO POLI DISCRETI ----------------------------

% ----------------- CALCOLO MODULO POLI DISCRETI --------------------------
modPolesZPlantD = abs(polesZPlantD)
modPolesYPlantD = abs(polesYPlantD)
modPolesZClosedLoopD = abs(polesZClosedLoopD)
modPolesTClosedLoopD = abs(polesTClosedLoopD)
modPolesYClosedLoopD = abs(polesYClosedLoopD)
% ----------------- FINE CALCOLO MODULO POLI DISCRETI ---------------------

% ----------------- CALCOLO MODULO POLI DISCRETI --------------------------
marginZ = allmargin(fdtClosedLoopz)
marginT = allmargin(fdtClosedLoopt)
marginY = allmargin(fdtClosedLoopy)
% ----------------- FINE CALCOLO MODULO POLI DISCRETI ---------------------

% ----------------- PLOT STEP RESPONSE SISTEMI DISCRETI -------------------
figure
step(fdtClosedLoopzDisc)
legend('z(t)')

figure
step(fdtClosedLoopyDisc)
legend('y(t)')
% ----------------- FINE PLOT STEP RESPONSE SISTEMI DISCRETI --------------