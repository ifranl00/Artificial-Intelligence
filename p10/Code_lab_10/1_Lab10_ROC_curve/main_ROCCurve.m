clear
close all

%% PRELIMINAR: CARGA CONJUNTO DE DATOS Y PARTICIÓN TRAIN-TEST

load mammographic_data.mat;
% X contiene los patrones de entrenamiento (dimensión 5)
% Y contiene la clase del patrón

% NORMALIZACIÓN DE LOS DATOS: Si esta bien normalizado va a salir media 0 y
% desviacion 1
% La clasificación se probará SIN y CON normalización
% ====================== YOUR CODE HERE ======================

med = mean(X);
desviacion = std(X);

[a,b] = size(X);

for j=1:b
    
        X(:,j) = (X(:,j) - med(j))/desviacion(j);
end
% 
% 

% ============================================================

% Número de patrones (elementos) y de variables por cada patrón en este dataset
[num_patrones, num_variables] = size(X);

% Parámetro que indica el porcentaje de patrones que se utilizarán en 
% el conjunto de entrenamiento
p_train = 0.7;

% Partición de los datos en conjuntos de entrenamiento y test. 

num_patrones_train = round(p_train*num_patrones);
%num_patrones_test = num_patrones - num_patrones_train;

ind_permuta = randperm(num_patrones);

inds_train = ind_permuta(1:num_patrones_train);
inds_test = ind_permuta(num_patrones_train+1:end);

X_train = X(inds_train, :);
Y_train = Y(inds_train);

X_test= X(inds_test, :);
Y_test = Y(inds_test);


%% PARTE 1: ENTRENAMIENTO DEL CLASIFICADOR Y CLASIFICACIÓN DEL CONJUNTO DE TEST

% La función fClassify_LogisticReg implementa el clasificador de la regresión 
% logística.
alpha = 2;

% ENTRENAMIENTO:
theta = fEntrena_LogisticReg(X_train, Y_train, alpha);

% CLASIFICACIÓN DEL CONJUNTO DE TEST
Y_test_hat = fClasifica_LogisticReg(X_test, theta);
Y_test_asig = Y_test_hat>=0.5;

% Muestra matriz de confusión
figure;
plotconfusion(Y_test, Y_test_asig);

%% PARTE 2: CURVA ROC

% ====================== YOUR CODE HERE ======================
% Llamada a fGetROC. Los umbrales de decisión que se usen tienen que estar 
% entre 1 y 0, EN ESTE ORDEN, para que la curva quede bien representada
umbrales = 1:-0.01:0; %%para que salgan suficientes puntos en los umbrales
[FPR,TPR] = fGetROC(Y_test, Y_test_hat,umbrales);
% ============================================================

figure; plot([0,FPR], [0,TPR]);
hold on;
line(0:0.01:1, 0:0.01:1, 'Color', 'red', 'LineStyle', '--');
legend('ROC clasificador', 'Clasificación aleatoria');
xlabel('FPR (1 - specificity)');
ylabel('TPR (sensitivity)');
hold off;

% Calcula el área bajo dicha curva
AUC = trapz(FPR, TPR);
fprintf('\n******\nArea bajo la curva = %1.4f \n', AUC);

% Para comprobar resultado: La curva debe ser similar
% [FPR_2,TPR_2,T,AUC] = perfcurve(Y_test, Y_test_hat, 1);
% figure; plot(FPR_2,TPR_2);
% hold on; 
% line(0:0.01:1, 0:0.01:1, 'Color', 'red', 'LineStyle', '--');
% legend('ROC clasificador', 'Clasificación aleatoria');
% xlabel('FPR (1 - specificity)');
% ylabel('TPR (sensitivity)');
% hold off;

