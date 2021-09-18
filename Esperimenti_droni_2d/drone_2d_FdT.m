%f = 1;
m = 0.2;
g = 9.8;

plantZNum = 1/m;
plantZDen = [1 0 0];

FdT_in = tf(plantZNum, plantZDen);
FdT_g = tf(1, plantZDen);

% Nope, non possono essere sommate così; posso però sommare le loro uscite
% FdT_z = FdT_in + FdT_g;

FdT_z;

% step(FdT_in);
step(FdT_g*g);