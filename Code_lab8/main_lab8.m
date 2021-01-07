%----------------------------------------
% CLASIFICADOR SVM + VALIDACION CRUZADA
%----------------------------------------

clear
close all

%% PRELIMINAR: CARGA CONJUNTO DE DATOS

load mammographic_data_norm.mat;
% X contiene los patrones de entrenamiento (cada patr�n en una columna): Patrones de dimensi�n 5
% Y contiene la clase del patr�n (1==maligna; 0==benigna)

% N�mero de patrones (elementos) y de variables por cada patr�n en este dataset
[num_patrones, num_variables] = size(X);

%% PARTE 1: CREAR K-FOLDS

k = 10;

% Crea las K divisiones para realizar la validaci�n cruzada
indices_folds = crear_k_fold(Y, k);

fprintf('*********************************************************\n');
fprintf('******* COMPROBACI�N DE PROPORCIONES EN LOS FOLDS *******\n');
fprintf('*********************************************************\n');
fprintf('\n');
fprintf('COMPLETE DATASET: %4.2f (Class 0) - %4.2f (Class 1)\n', 100*sum(Y==0)/length(Y), 100*sum(Y==1)/length(Y));
fprintf('\n');

for num_fold=1:max(indices_folds)
    indsFolds = indices_folds==num_fold;
    
    numClass0_k = sum(Y(indsFolds)==0);
    numClass1_k = sum(Y(indsFolds)==1);
    fprintf('FOLD %d: %4.2f (Class 0) - %4.2f (Class 1)\n', num_fold, 100*numClass0_k/sum(indsFolds), 100*numClass1_k/sum(indsFolds));
end
fprintf('\n');
fprintf('*********************************************************\n');
fprintf('*********************************************************\n');
fprintf('*********************************************************\n');
fprintf('\n');
fprintf('\n');
fprintf('\n');

%% PARTE 2: CLASIFICACI�N CON SVM
 
addpath('libsvm-3.20/matlab');

% *******************************************************
% Clasificaci�n usando Validaci�n Cruzada

% Par�metro C de SVM. PROBAR CON DIFERENTES Y VER SU IMPACTO EN LA
% CLASIFICACI�N
C_val = 1; 

% Inicializaci�n de vectores de resultados
accuracies = zeros(1, num_fold);
FScores = zeros(1, num_fold);

for num_fold = 1:max(indices_folds)
    
    % Obtenci�n de los �ndices asignados al num_fold-�simo fold. 
    % indsTest es un vector donde est�n las posiciones donde indices_folds 
    % valga num_fold
    % indsTrain es un vector donde est�n las posiciones donde indices_folds
    % tenga un valor distinto de num_fold
    % ====================== YOUR CODE HERE ======================

    indsTest=find(indices_folds == num_fold);
    indsTrain=find(indices_folds ~= num_fold);
	% ============================================================
    
    % Separaci�n entre conjuntos de test (con los patrones que
    % est�n en el fold num_fold) y entrenamiento (todos los dem�s)
    % SE TRANSPONEN LAS Y PORQUE LIBSVM ESPERA LOS VECTORES CON LAS CLASES 
    % COMO VECTORES COLUMNA. LAS X NO SE TRANSPONEN PORQUE LOS PATRONES DEL 
    % CONJUNTO DE DATOS TIENEN QUE ESTAR EN FILAS
    X_test_fold = X(indsTest, :);
    Y_test_fold = Y(indsTest)';
    X_train_fold = X(indsTrain, :);
    Y_train_fold = Y(indsTrain)';
    
    % Entrenamiento de SVM
    opt_string=['-t 0 -e 0.001 -c ' num2str(C_val)];
    % ====================== YOUR CODE HERE ======================
    model = svmtrain_2(Y_train_fold, X_train_fold, opt_string);
    
	% ============================================================
    
    % Test de SVM
    % ====================== YOUR CODE HERE ======================

    predict = svmpredict_2(Y_test_fold, X_test_fold, model);
	% ============================================================
    
    % C�lculo del accuracy para este fold
	% ====================== YOUR CODE HERE ======================
    
    TP = 0;
    TN = 0;
    FP = 0;
    FN = 0;
    
    for i = 1: length(Y_test_fold)
        if Y_test_fold(i) == predict(i) && Y_test_fold(i) == 1
        
            TP = TP +1;
        
        elseif Y_test_fold(i) ~= predict(i) && Y_test_fold(i) == 1
            
            FN = FN + 1;
        
        elseif Y_test_fold(i) ~= predict(i) && Y_test_fold(i) == 0
            
            FP = FP + 1;
       
        elseif Y_test_fold(i) == predict(i) && Y_test_fold(i) == 0
        
            TN = TN +1;
        end
    
    end

    % El accuracy de cada fold se acumula en un vector para poder calcular
    % su media y desviaci�n t�pica fuera del bucle
	accuracies(num_fold) = (TP+TN)/(TP+TN+FP+FN);
	% ============================================================
    
    % C�lculo del F-Score para este fold
    % ====================== YOUR CODE HERE ======================

    precision = TP/(TP+FP);
    recall = TP/(TP+FN);
    % El FScore de cada fold se acumula en un vector para poder calcular
    % su media fuera del bucle
	FScores(num_fold) = 2*((precision*recall)/(precision+recall));
	% ============================================================
    
end

% *******************************************************

% B: Mostramos resultados
fprintf('\n\n');
fprintf('**********************************************************************\n');
fprintf('******* RESULTADOS DE LA CLASIFICACI�N CON VALIDACI�N. CRUZADA *******\n');
fprintf('**********************************************************************\n');
fprintf('\n');

for num_fold=1:max(indices_folds)
        
    fprintf('FOLD %d: Accuracy = %4.2f - FScore = %4.2f (Class 1)\n', num_fold, accuracies(num_fold), FScores(num_fold));
end

fprintf('\n');
fprintf('AVERAGE ACCURACY = %4.2f  - STD ACCURACY = %4.2f \n', mean(accuracies), std(accuracies));
fprintf('AVERAGE FSCORE = %4.2f  - STD FSCORE = %4.2f \n', mean(FScores), std(FScores));
fprintf('\n');
fprintf('**********************************************************************\n');
fprintf('**********************************************************************\n');
fprintf('**********************************************************************\n');
fprintf('\n');
fprintf('\n');
fprintf('\n');