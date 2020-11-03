%------------------------------------
% CLASIFICADOR REGRESION LOGISTICA
%------------------------------------

clear
close all

%% PRELIMINAR: CARGA CONJUNTO DE DATOS Y PARTICI?N TRAIN-TEST

load mammographic_data_norm.mat;
% X contiene los patrones de entrenamiento (dimension 5)
% Y contiene la clase del patron

% Numero de patrones (elementos) y de variables por cada patron en este dataset
[num_patrones, num_variables] = size(X);

% Parametro que indica el porcentaje de patrones que se utilizaran en 
% el conjunto de entrenamiento
p_train = 0.7;

% Particion de los datos en conjuntos de entrenamiento y test. 

num_patrones_train = round(p_train*num_patrones);
%num_patrones_test = num_patrones - num_patrones_train;

ind_permuta = randperm(num_patrones);

inds_train = ind_permuta(1:num_patrones_train);
inds_test = ind_permuta(num_patrones_train+1:end);

X_train = X(inds_train, :);
Y_train = Y(inds_train);

X_test= X(inds_test, :);
Y_test = Y(inds_test);

%% PARTE 1: ENTRENAMIENTO DEL CLASIFICADOR Y CLASIFICACION DEL CONJUNTO DE TEST

% La funcion fClassify_LogisticReg implementa el clasificador de la regresion 
% logistica. Abrela y completa el codigo
alpha = 2;
umbral_decision = 0.5;

% ENTRENAMIENTO
theta = fEntrena_LogisticReg(X_train, Y_train, alpha);

% CLASIFICACION DEL CONJUNTO DE TEST
Y_test_hat = fClasifica_LogisticReg(X_test, theta);
Y_test_asig = Y_test_hat>=umbral_decision;

%% PARTE 2: RENDIMIENTO DEL CLASIFICADOR: CALCULO DEl ACCURACY Y FSCORE

% Muestra matriz de confusion
figure;
plotconfusion(Y_test, Y_test_asig);

TP = 0;
FN = 0;
FP = 0;
TN = 0;

for i = 1: length(Y_test)
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

% F-SCORE
% ====================== YOUR CODE HERE ======================
recall = sum(Y_test_asig==1 & Y_test==1)/sum(Y_test==1);
precision =  TP /(TP+FN);

FScore = 2* ((precision*recall)/(precision + recall));
% ============================================================
fprintf('\n******\nFScore = %1.4f (classification)\n', FScore);

