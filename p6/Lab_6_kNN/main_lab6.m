%------------------------------------
% CLASIFICADOR K VECINOS M�?S PROXIMOS
%------------------------------------

clear

%% PARTE 1: CARGA CONJUNTO DE DATOS Y PARTICI?N TRAIN-TEST

load spambase_data.mat;
% X contiene los elementos que se van a estudiar (cada fila corresponde a un vector de caracterí?sticas)
% Y contiene la clase de cada elemento 

% Número de elementos del dataset y de variables que tiene cada uno 
[num_patrones, num_variables] = size(X);

% Parámetro que indica el porcentaje de elementos que se utilizarán en 
% el conjunto de entrenamiento
p_train = 0.7;

% En la siguiente sección de código se realiza la partición de los datos en 
% entrenamiento y test. Indica qué realiza cada línea de código mediante 
% comentarios.
% ============================================

num_patrones_train = round(p_train*num_patrones); %% El numero de patrones de entrenamiento se cogen un 70 por cierto y se redondean

ind_permuta = randperm(num_patrones); %% permutamos aleatoriamente en un vector fila de los patrones

inds_train = ind_permuta(1:num_patrones_train); %% entrenamiento : guarda los valores de los parametros permutados anteriormente desde 1 hasta el numero de patrones de entrenamiento
inds_test = ind_permuta(num_patrones_train+1:end); %% test : guarda los valores de los parametros permutados anteriormente desde el siguiente al ultimo guardado para el entrenamiento hasta el final

X_train = X(inds_train, :); %% Guardamos en cada fila un vector de caracteristicas de los datos de entrenamiento
Y_train = Y(inds_train); %% Guardamos la clase de los datos de entrenamiento

X_test= X(inds_test, :); %% Guardamos en cada fila un vector de caracteristicas de los datos de test
Y_test = Y(inds_test); %% Guardamos la clase de los datos de test

% ============================================

%% PARTE 2: ALGORITMO DE LOS K VECINOS M�?S CERCANOS

% La función fClassify_kNN ejecuta el algoritmo de kNN. �?brela y completa 
% el código
k=3;

Y_test_asig = fClassify_kNN(X_train, Y_train, X_test, k);


%% PARTE 3: EVALUACIÓN DEL RENDMIENTO DEL CLASIFICADOR

% Muestra matriz de confusión
plotconfusion(Y_test, Y_test_asig);

%%inicializamos las matrices donde guardamos los elementos de la tabla de
%%confusion por posiciones

TP = 0;
FN = 0;
FP = 0;
TN = 0;

for i=1: length(Y_test)
    
    if Y_test(i) == Y_test_asig(i) && Y_test(i) == 1
        
        TP = TP +1;
        
    elseif Y_test(i) ~= Y_test_asig(i) && Y_test(i) == 1
            
        FN = FN + 1;
        
    elseif Y_test(i) ~= Y_test_asig(i) && Y_test(i) == 0
            
       FP = FP + 1;
       
    elseif Y_test(i) == Y_test_asig(i) && Y_test(i) == 0
        
       TN = TN +1;
    end
end


% Error--> Error global
% ====================== YOUR CODE HERE ======================
    error = (FP + FN) / (TP + TN + FP + FN);
% ============================================================
fprintf('\n******\nError global = %1.4f%% (classification)\n', error*100);

% Tasa de falsa aceptaci?n
% ====================== YOUR CODE HERE ======================
  FPR = FP/(FP+TN);
% ============================================================
fprintf('\n******\nTasa de falsa aceptación = %1.4f%% (classification)\n', FPR*100);

% Tasa de falso rechazo
% ====================== YOUR CODE HERE ======================
    FNR = FN/ (TP+FN);
% ============================================================
fprintf('\n******\nTasa de falso rechazo = %1.4f%% (classification)\n', FNR*100);

% Precision
% ====================== YOUR CODE HERE ======================
precision =  TP /(TP+FN);
% ============================================================
fprintf('\n******\nPrecision = %1.4f%% (classification)\n', precision*100);

% Recall
% ====================== YOUR CODE HERE ======================

recall = sum(Y_test_asig==1 & Y_test==1)/sum(Y_test==1);

% ============================================================
fprintf('\n******\nRecall = %1.4f%% (classification)\n', recall*100);

