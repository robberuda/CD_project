%f = 1;
m = 0.2;
g = 9.8;
i = 0.1;

plantZNum = 1/m;
plantZDen = [1 0 0];

fdtPlantZ = tf(plantZNum, plantZDen);
fdt_g = tf(1, plantZDen);

% Nope, non possono essere sommate così; posso però sommare le loro uscite
% fdt_z = fdt_in + fdt_g;

% step(fdt_in);
% step(fdt_g*g);

%fdt_z;

Pz = 0.65;
Iz = 0.3;
Dz = 0.35;
Nz = 100;

fdtPznum = 0.65;
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
fdtDz = Dz*Nz/fdtDden;

fdtCtrlz = fdtPz + fdtIz + fdtDz;

fdtPlantCtrlz = fdtPlantZ*fdtCtrlz;
% fdtClosedLoop = fdtPlantCtrlz/( 1 + fdtPlantCtrlz ) %???????????????
fdtClosedLoop = feedback(fdtPlantCtrlz, 1);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plantyNum = 1/m;
plantyDen = [1 0 0];

fdtPlanty = tf(plantyNum, plantyDen);

Py = 0.5;
Iy = 0;
Dy = 0.4;
Ny = 100;

fdtPynum = 0.65;
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
fdtDy = Dy*Ny/fdtDden;

fdtCtrly = fdtPy + fdtIy + fdtDy;

fdtPlantCtrly = fdtPlanty*fdtCtrly;
% fdtClosedLoop = fdtPlantCtrly/( 1 + fdtPlantCtrly ) %???????????????
fdtClosedLoop = feedback(fdtPlantCtrly, 1);

