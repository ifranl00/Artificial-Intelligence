% Creación de la matriz aleatoria
% Dimensiones 20 x 20 y valores entre 0 y 3
% Generar una matriz cuadrada en la que cada uno de los valores sea un valor
% aleatorio comprendido entre 0 y 3 con 400 puntos. Determinar:
A = (3-0)*rand(20)+0;
    
% Apartado 1 : Filas y columnas de los elementos de la matriz cuyo valor esté comprendido
% entre 1 y 2
[Ap11, Ap12] = find(A >1 & A <2);

% Apartado 2 : Elementos de la matriz cuyo valor sean o menores que 1 o mayores de dos
Ap2 = A(find(A < 1 | A > 2));

%Apartado 3 : Redondear los elementos de la matriz al entero más próximo y determinar los
% valores que no son iguales a 1.
Ap31 = round(A);

Ap3 = Ap31(find(Ap31 ~=1));