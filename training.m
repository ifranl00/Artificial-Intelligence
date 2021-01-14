rng(6077);
N=20;
A=[randn(N/2,1) rand(N/2,1)+0.5;randn(N/2,1) -rand(N/2,1)-0.5]
angle=randn(1);
x(:,1)=A(:,1)*cos(angle)-A(:,2)*sin(angle);
x(:,2)=A(:,1)*sin(angle)+A(:,2)*cos(angle);
x=x+randn(1,2);
y=sign(A(:,2));

save data.mat;