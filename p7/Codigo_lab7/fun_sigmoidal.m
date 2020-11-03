function g = fun_sigmoidal(theta, x)
% Esta funcion calcula la funcion sigmoidal g(z), donde z es la combinacion
% lineal de los parametros theta y de las X
%
% INPUT
%	- theta: Parametros de la funcion de hipotesis (h) del clasificador 
%   calculados durante el algoritmo de regresion logistica.
% 	- X: Vector que contiene los datos de un patron.
%
% OUTPUT
%	g: Resultado de aplicar la funcion sigmoidal utilizando la combinacion 
%   lineal de theta y x como parametro.
%

	% ====================== YOUR CODE HERE ======================
    thetaTransp = sum(theta .*x); 
	g = 1/(1+exp(-thetaTransp));
    % ============================================================
	
end