function [vFPR, vTPR] = fGetROC(Y_test, Y_test_hat, umbrales_decision)
% Esta funci�n obtiene los valores de Tasa de Falsa Aceptaci�n (FPR) y Tasa
% de Verdadera Aceptaci�n (TPR) que definen la curva ROC, para ciertos 
% umbrales de decisi�n. Adem�s, calcula el �rea bajo dicha curva. Esta
% funci�n est� dise�ada para problemas de clasificaci�n binaria (.
%
% INPUT
%   - Y_test: Vector que contiene las clases reales (0 o 1) de los
%   elementos del conjunto de test.
%   - Y_test_hat: Vector que contiene las salidas del clasificador. Estas 
%   salidas corresponden con la probabilidad de los patrones clasificados
%   de pertenecer a la clase positiva.
%   - umbrales_decision: Vector con los diferentes umbrales de decisi�n que 
%   se utilizar�n para generar los valores de FPR y TPR.
%
% OUTPUT
%   - vFPR: Vector con el mismo n�mero de elementos que umbrales_decision
%   que contiene los valores de FPR para cada umbral de decisi�n utilizado.
%   - vTPR: Vector con el mismo n�mero de elementos que umbrales_decision
%   que contiene los valores de TPR para cada umbral de decisi�n utilizado.
%

    vFPR = zeros(1, length(umbrales_decision));
    vTPR = zeros(1, length(umbrales_decision));
    
    % ====================== YOUR CODE HERE ======================
    
    for j=1:length(umbrales_decision)
        umbral = umbrales_decision(j);
        
        predictor = Y_test_hat >= umbral;
        
        TP = 0;
        FN = 0;
        FP = 0;
        TN = 0;

        for i=1: length(Y_test)

            if Y_test(i) == predictor(i) && Y_test(i) == 1

                TP = TP +1;

            elseif Y_test(i) ~= predictor(i) && Y_test(i) == 1

                FN = FN + 1;

            elseif Y_test(i) ~= predictor(i) && Y_test(i) == 0

                FP = FP + 1;

            elseif Y_test(i) == predictor(i) && Y_test(i) == 0

                TN = TN +1;
            end
        end

         vTNR(j) = TN/ (FP+TN);
         vFPR(j) = FP/ (FP+TN);
         vFNR(j) = FN/ (TP+FN);
         vTPR(j) = TP/ (TP+FN);
        
    end
        
    
        
    % ============================================================

end
