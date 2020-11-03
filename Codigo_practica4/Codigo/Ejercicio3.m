%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Creación de una script va a almacenar los datos de una matriz en dos
% ficheros de texto diferentes.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Creación de la matriz
matriz = magic(6); %%suman lo mismo filas y columnas

% Creación del fichero de texto 'matriz.txt' que tiene que estar separado
% por tabuladores. Utilizar funciones de fopen y fprintf

file = fopen('matriz.txt', 'w');
for i=1:length(matriz(:,1))
    for j=1:length(matriz(1,:))
    fprintf(file,'%d\t', matriz(i,j) );    
    end
    fprintf(file, '\n');
end

fclose(file);
    

% Creación del fichero de texto 'matriz.csv' que tiene que ser un fichero
% csv delimitado por ';'

file2 =fopen('matriz.csv', 'w');
for i=1:length(matriz(:,1))
    for j=1:length(matriz(1,:))
    fprintf(file2, '%d;', matriz(i,j));
    end
    fprintf(file2, '\n');
end
fclose(file2);


