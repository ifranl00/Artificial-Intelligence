%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Crear en una figura tres gr�ficas en las que se representen las
% relaciones trigonom�tricas del �ngulo alpha y alpha +pi/4. Una gr�fica
% ser� cont�nua en color rojo y la otra discontinua en color negro.
% Etiquetar cada una de ellas convenientemente
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Definimos la variable �ngulo que va a ser el eje de las x
alpha=0:pi/8:6*pi;

% Inicializamos la figura

figure();

% Ploteamos la primera gr�fica cos(alpha) & cos(alpha + pi/4)
% Ponemos t�tulo y leyenda
subplot(311);

x = cos(alpha);
y = cos(alpha+pi/4);
plot(alpha, x, 'r-',alpha, y, 'k--');
title('Funcion coseno');
legend('alpha','alpha + pi/4');
    
% Ploteamos la segunda gr�fica sin(alpha) & sin(alpha + pi/4)
% Ponemos t�tulo y leyenda

subplot(312);

z = sin(alpha);
w = sin(alpha+pi/4);
plot(alpha, z, 'r-',alpha, w, 'k--');
title('Funcion seno');
legend('alpha','alpha + pi/4');

% Ploteamos la tercera gr�fica tan(alpha) & tan(alpha + pi/4)
% Ponemos t�tulo y leyenda y hay que limitar el eje y para que est� entre
% los valores -10 y 10
subplot(313);

q= tan(alpha);
t= tan(alpha +pi/4);
plot(alpha, q, 'r-', alpha, t, 'k--');
ylim([-10,10]);
title('Funcion tangente');
legend('alpha','alpha + pi/4');

%%despues de plot y subplot ponemos: ylim([-10,10])