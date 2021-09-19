% Nope, non possono essere sommate così; posso però sommare le loro uscite
% fdt_z = fdt_in + fdt_g;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funzione di trasferimento sistema evoluzione lungo z

m = 0.2;
g = 9.8;
i = 0.1;

Tc = 0.01;
method = 'tustin';

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
fdtDzdenden = [1, 0];
fdtDzden = 1+Nz*tf(fdtDzdennum, fdtDzdenden);

fdtPz = tf(fdtPznum, fdtPzden);
fdtIz = tf(fdtIznum, fdtIzden);
% fdtDz = tf(fdtDznum, fdtDzden);
fdtDz = Dz*Nz/fdtDzden;

fdtCtrlz = fdtPz + fdtIz + fdtDz;

fdtPlantCtrlz = fdtPlantZ*fdtCtrlz;
% fdtClosedLoopz = fdtPlantCtrlz/( 1 + fdtPlantCtrlz ) %???????????????
fdtClosedLoopz = feedback(fdtPlantCtrlz, 1);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funzione di trasferimento sistema evoluzione lungo t

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
% fdtClosedLoopt = fdtPlantCtrlt/( 1 + fdtPlantCtrlt ) %???????????????
fdtClosedLoopt = feedback(fdtPlantCtrlt, 1);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funzione di trasferimento sistema evoluzione lungo y

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



%%%%%%%%%
% discretization
fdtPlantZdisc = c2d(fdtPlantZ, Tc, method)
