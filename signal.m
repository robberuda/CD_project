%[y,z,t]
% Questi dovrebbero essere i vertici della stella, i punti da raggiungere
WayPts = [[0,0,1];
          [0,-1,2];
          [3,-4,6];
          [-1,-4,10];
          [2,-1,14];
          [1,-5.5,18];
          [0,-1,22];
          %[0,-9,24];
          %[4,-7,37];
          %[-2,-3,42];
          %[-3,-6,47];
          %[-1,-7,52]
          ]

% Qui ci dovrebbe essere la derivata della posizione, cioè la velocità
% (media) del drone in ciascuno dei tratti che costituiscono la stella
dY = []
dZ = []

% calcolo le velocità medie sopracitate (non istante per istante, ma,
% di nuovo, una velocità media che è uguale per tutto il segmento della
% stella
for i = 1:length(WayPts)-2
    dY(i) = (WayPts(i+2,1)-WayPts(i+1,1))/(WayPts(i+2,3)-WayPts(i+1,3))
    dZ(i) = (WayPts(i+2,2)-WayPts(i+1,2))/(WayPts(i+2,3)-WayPts(i+1,3))
end

% definisco: quanto dura la simulazione, il tempo di volo (?)
% il tempo di quantizzazione, l'insieme degli istanti in cui calcolerò
% lo stato
Tfinal = 30;
TOFtime = 1
ts = 0.1
t = 0:ts:Tfinal

% Superpose signals
% y_sum e z_sum sono tipo degli accumulatori, nel tempo. Nel senso:
% sono comunque array, ma ogni cella è l'accumulatore della posizione
% fino a quell'istante, ottenuta sommando le variazioni in ogni istnate
% temporale. 
% Es:
%   z(0)-> posizione all'istante 0
%   z(1)-> posizione all'istante 1 (sommo a quella di prima il delta z)
%   z(1)-> posizione all'istante 1 (sommo a z(1) il niovo delta z)
%   e così via...
z_sum = 0*t
y_sum = 0*t
for k = 1:length(WayPts)
    % gli istanti di tempo tra l'inzio e il primo punto della stella,
    % sono da passare stando fermo
    if k == 1
        section = [0, WayPts(k,3)];
        start_section = section(1);
        end_section = section(2);
        
        for i = 1:length(z_sum)
            if t(i) >= start_section && t(i) <= end_section
                z_sum(i) = 0;
                y_sum(i) = 0;
            end
        end
    
    % qui invece, non so ancora perché, mette il drone ad altezza -1
    % direi quasi quasi di provare a toglierlo per vedere cosa succede
    elseif k == 2
        section = [WayPts(k-1,3),WayPts(k,3)]
        start_section = section(1);
        end_section = section(2);
        
        for i = 1:length(z_sum)
            if t(i) > start_section && t(i) <= end_section
                z_sum(i) = -1;
                y_sum(i) = 0;
            end
        end
    
    % per il generico punto, calcolo la posizione sommando la posizione
    % dell'istante precedente con l'intervallo ottenuto dal prodotto di
    % velocità media del segmento (calcolata a inizio script) per
    % intervallino di tempo (tempo di quantizzazione)
    else
        section = [WayPts(k-1,3),WayPts(k,3)]
        start_section = section(1);
        end_section = section(2);
        
        for i = 1:length(z_sum)            
            if t(i) > start_section && t(i) <= end_section
                z_sum(i) = z_sum(i-1) + ts*dZ(k-2);
                y_sum(i) = y_sum(i-1) + ts*dY(k-2);
            end
        end
        
    end
end

% considero tanti istanti quanti sono i vertici della traiettoria (?) 
% Ma che senso ha? 
start_section = WayPts(length(WayPts),3)
end_section = Tfinal
% traslo indietro di una posizione tutti i punti della traiettoria
%   1 - a cosa serve? Cazzo cambia un punto?
%   2 ma un modo più efficiente ed elegante che non un ciclo for?
% io direi di togliere del tutto questa parte, almeno per vedere cosa
% succede
for i = 1:length(z_sum)
    if t(i) > start_section && t(i) <= end_section
        z_sum(i) = z_sum(i-1)
        y_sum(i) = y_sum(i-1)
    end
end

% Generate timeseries cmd
% Ok, in pratica, per fare le time series, serve una matrice nx2.
% Due colonne: la prima il tempo, la seconda la grandezza di interesse. Si
% metteno i valori in modo che combacino, poi do la matrice così costruita
% in pasto alla funzione timeseries (?)
% In realtà non è strettamente necessario. Posso fare anche timeseries
% senza il riferimento temporale.
% E anche per quelle con il riferimento temporale, mi basta passare due
% vettori diversi, quello della grandezza fisica che mi interessa, e gli
% istnait di tempo corrispondenti
sigZ = [t;z_sum]
Zcmd = timeseries(sigZ(2:end,:),sigZ(1,:))
sigY = [t;y_sum]
Ycmd = timeseries(sigY(2:end,:),sigY(1,:))

% De-alloca lo spazio usato dalle variabili di lavoro, le quali infatti non
% servono più ai fini della simulazione
% clear section
% clear start_section
% clear end_section
% clear y_sum
% clear z_sum
% clear i
% clear k

