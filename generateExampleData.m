Tfinal = 50;
tss = 0.1;
time = 1:tss:Tfinal;

x = 4*sin(time);
y = 2*cos(time);
b = 0;
P = zeros(length(time), 3);


for i = 1:length(x)
    P(i,1)= x(i);
    P(i,2)= y(i);
    P(i,3)= b;
    P(i,4)= time(i);
end
    
clear i;


clear x;
clear y;
clear b;
clear t;
