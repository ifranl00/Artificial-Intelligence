%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Visualizacion de datos por medio de una pca %%
% Programación de un script que realiza una pca sobre unos datos de entrada
% Este script realiza la lectura de un fichero de datos y realiza una pca,
% la seleccion del numero de variables se realizará o bien de forma
% automática o se insertará por código.

%% Parámetros
% Selección del número de componentes principales.
k = 2; % k no puede ser 0

% Carga de los datos
load('datos_iris.mat');

%% Ploteo de los datos originales

% Se crea un scatter de los datos en 3D en el cual la posicion es
% indiciativa de las tres primeras propiedades de la flor, el tamaño del
% punto de la cuarta propiedad y el color de la clase.
figure()
for i=1:length(tiposIris)
    % Se aisla cada grupo de datos
    datos_in = X(Y==i, :);
    % Se añade al scatter cada grupo de datos
    scatter3(datos_in(:,1), datos_in(:,2), datos_in(:,3), (datos_in(:,4)*50), Y(Y==i), 'filled');
    % Se marca con un texto el tipo de planta de cada grupo
    text(mean(datos_in(:,1)), mean(datos_in(:,2)), mean(datos_in(:,3)), tiposIris(i), 'FontSize', 14);
    hold on
end

%% Programa de la PCA
% En ese apartado se programará la PCA de acuerdo al algortimo visto en
% clase.

% 1. Normalización de los datos. La normalización consistirá en la
% tipificación: restar a cada variable la media de esa variable en todos 
% los vectores de características (en este caso: la media de toda la columa 
% correspondiente) y dividirla entre la desviación típica de esa variable
% en todos los vectores de características
% ====================== YOUR CODE HERE ======================
X_noNorm = X; %%consevamos los datos no normalizados para mostrar los resultados, si eso modificar X

med = mean(X);
desviacion = std(X);

[a,b] = size(X);

for j=1:b
    
        X(:,j) = (X(:,j) - med(j))/desviacion(j);
end
% ============================================================

% 2. Cálculo de la matriz de covarianza
% ====================== YOUR CODE HERE ======================

MatrixCov = cov(X);

% ============================================================

% 3. Obtención de los autovalores y autovectoresvectores de la matriz de
% covarianza de los datos.
% ====================== YOUR CODE HERE ======================
%%usar funcion eig(_) para obtener los autovalores y autovectores 
[autoVect, autoVal] = eig(MatrixCov);
autoVal = diag(autoVal);
autoVal = autoVal';
% ============================================================

% 4. Ordenación de los autovectores en función de sus valores singulares
% asociados de mayor a menor. 
% ====================== YOUR CODE HERE ======================
[autoValOrdenado, inds] = sort(autoVal, 'descend');
% ============================================================


% 5. Crear la matriz de componentes principales
% Seleccionar los k primeros autovectores (después de ordenarlos en el
% paso 4)
% ====================== YOUR CODE HERE ======================
    select_ord = inds(1:k);
    
    vect_ord = autoVect(:,select_ord);
% ============================================================

% 6. Obtenemos los nuevos datos
% Es lo mismo que multiplicar la matriz de componentes principales por 
% la de los datos para obtener los valores con las nuevas corrdenadas.
% ====================== YOUR CODE HERE ======================
DatosPCASol =X * vect_ord ;
% ============================================================

%% Ploteo del resultado de la PCA cuando k = 2
% Se va a crear un subplot para cada variable, la posicion de los puntos
% se determina por medio de las coordenadas PCA, el radio del punto va
% a depender en cada caso de una de las variables originales.
if(k==2)
    figure();
    % Recorremos los subplots para plotear en cada uno una cosa
    for i=1:length(tiposIris)
        index = Y==i;
        % Ploteamos los datos como puntos
        scatter(DatosPCASol(index,1), DatosPCASol(index,2), X_noNorm(index,4)*50, Y(Y==i),'filled');
        % Añadimos el texto correspondiente a cada grupo
        text(mean(DatosPCASol(index,1)), mean(DatosPCASol(index,2)), tiposIris(i), 'FontSize', 14);
        hold on
    end    
end
