
clc
% %Rosenblatt's Perecptron
load data.mat;

[m n]=size(x);
%training data
 xtrain=x(1:18,:); 
 ytrain=y(1:18);
% test data
xt=x(19:m,:); 
yt=y(19:m);
%=====================================
% Train the perceptron
%=====================================




tic
[l,p]=size(xtrain);
w=zeros(p,1);  % initialize weights
b=0;          % initialize bias
ier=1;        % initialize a misclassification indicator
pass=0;       % number of iterations
n=0.8;        % learning rate
r=max(sqrt(sum(xtrain))); % max norm

while sign(w'*xtrain' -b ) ~= ytrain %repeat until no error
       ier=0; 
       e=0; % number of training errors
       for i=1:l  % a pass through x           
           xx=xtrain(i,:);
           ey=xx*w - b; % estimated y
          

           if sign(ey)~= ytrain(i)
              w=w'+(n*ytrain(i))*(xtrain(i,:)); % don't know why itdoes npt work              
              b=b-(n*ytrain(i)*(r^2));       % don't know why itdoes npt work               
              e=e+1 ; % number of training errors
              w=w';   
           end
       end
       ee=e;    % number of training errors
       if ee>0  % cuntinue if there is still errors
          ier=1;           
       end
       pass=pass+1; % stop after 10000 iterations
       if pass==10000
          ier=0;
          pass=0;
       end
end
fprintf("%i    %i    %i",w,b,pass);
disp(['Training_Errors=' num2str(e) '     Training data Size=' num2str(l)])
toc
Iterations=pass;
%==========================================
% Testing phase
%==========================================

[l,p]=size(xt);
e=0; % number of test errors
for i=1:l          
    xx=xt(i,:); % take one row
    ey=xx*w-b; % apply the perceptron classification rule

    if yt(i)~=sign(ey)
       e=e+1;
    end
end

disp(['Test_Errors=' num2str(e) '     Test Data Size= ' num2str(10)])



 l=y==0;
 hold on
 plot(x(l,1),x(l,2),'k.' );
 plot(x(~l,1),x(~l,2),'g.');
 [l,p]=size(x);
 plot([0,1],[0,1],'r-')
 axis([0 1 0 1]), axis square, grid on
 drawnow
