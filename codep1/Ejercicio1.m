% Creación de la matriz
Matriz1 = [1 -3 5; 9 3 1;2 -1 4];
% Apartado 1
Matriz2 = Matriz1';
% Apartado 2
Matrizp = Matriz1 .* Matriz2;
% Apartado 3
Matriz3 = Matriz1 + Matrizp;
% Apartado 4
prodM1M2 = Matriz1 * Matriz2;
% Apartado 5
prodM2M1 = Matriz2 * Matriz1;
% Apartado 6
Matriz1b = Matriz1;
Matriz1b(2,2) = 9;
% Apartado 7
szM1 = size(Matriz1);
m = szM1(1,1); %numero de filas
n = szM1(1,2); %numero columnas
esquina1 = Matriz1(1,1);
esquina2 = Matriz1(1,n);
esquina3 = Matriz1(m,1);
esquina4 = Matriz1(m,n);
esquinas = [esquina1 esquina2 ; esquina3 esquina4];
% Apartado 8
diagonalM1 = diag(Matriz1)';
% Apartado 9
diagonalM2 = Matriz1(1,:)';
% Apartado 10
escalar = diagonalM1 .* diagonalM2';
% Apartado 11
vectorial = diagonalM1 * diagonalM2;