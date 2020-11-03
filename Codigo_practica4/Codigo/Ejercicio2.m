%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script que va a pedir por pantalla varios datos referente a partículas
% que se van a plotear y calcular su centro de masas
% NO MODIFICAR EL NOMBRE DE LAS VARIABLES QUE SE INCUYEN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Se pide por pantalla el número de particulas que se va introducir.
nParticulas = input('Introduzca numero de particulas del sistema: ');

% Se inicializa la matriz que va a almacenar las coordenadas y la masa de
% cada una de las partículas
particulas = zeros(nParticulas,3) ;

% Se van pidiendo por pantalla los datos de todas las particulas
for i=1:nParticulas
    
    particulas(i,1) = input(['Particula', num2str(i) ,'. Posicion X:']);
    particulas(i,2) = input(['Particula',  num2str(i) ,'. Posicion Y:']);
    particulas(i,3) = input('Masa:');
    
end

% Se iniciliza la variable donde se va a almacenar el centro de masas

centroDeMasasX = zeros(1,1); 
centroDeMasaY = zeros(1,1);
    
% Se calcula el centro de masas

centroDeMasasX (1,1)=  sum(particulas(:,1) .* particulas(:,3))/sum(particulas(:,3));
centroDeMasasY (1,1)=  sum(particulas(:,2) .* particulas(:,3))/sum(particulas(:,3));
    
% Inicializamos la figura en la que se van a plotear los datos

figure();
scatter(particulas(:,1),particulas(:,2), 25,'filled');
hold on;
plot(centroDeMasasX(1,1),centroDeMasasY(1,1),'rx');
ylim([0,10]);
xlim([0,10]);
x = particulas(:,1);
y = particulas(:,2);

% Se plotea cada una de las partículas añadiendo el número de la particula
% con una etiqueta en la que se inidica el valor de la masa.


for i=1:nParticulas 
  
    masa1 = num2str(particulas(i,3));
    text(x(i),y(i),masa1);
   
end

