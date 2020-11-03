% Creación de la matriz aleatoria de enteros
% Dimensiones tienen que ser 10 x 4 y los valores comprendidos entre -10 y
% 10
% Generar una matriz aleatoria cuyos valores sean enteros y estén comprendidos
%en el intervalo -10 y 10. Las dimensiones de la matriz serán de diez filas y 4 columnas.

A =double(int32((10-(-10))*rand(10,4)-10));
%A = randi([-10,10], 10, 4]);
    
% Inicialización de la matriz de distancias
Dist = zeros(length(A));

% Relleno de la matriz de distancias
% Crear una matriz cuyas dimensiones sean 10 x 10 cuyos elementos sean las
% distancias euclídeas entre todos los elementos de la matriz generada aleatoria.
for i=1:10
    for j=1:10
        suma = 0;
        for k= 1:4
           suma = suma + (A(i,k) - A(j,k))^2;
        end
         Dist(i,j)=sqrt(suma);
    end
end

%NO USAR Test_Ejer2. 
Dist2 = squareform(pdist(double(A), 'euclidean'));
if sum(sum(Dist==Dist2))==100
    disp('El resultado es correcto')
end