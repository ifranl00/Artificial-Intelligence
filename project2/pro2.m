clc
%import our Calculate Data
load data.mat;
%inicialate size of training and total size
NumTraining=18;
TotalSize=20;
%divide our x in train and test
xtrain=x(1:NumTraining,:); 
ytrain=y(1:NumTraining);

xtest=x(NumTraining+1:TotalSize,:); 
ytest=y(NumTraining+1:TotalSize);

%train

[l,p]=size(xtrain);
w=zeros(p,1); 
b=0;         
pass=0;       
n=0.8;        
r=max(sqrt(sum(xtrain))); 

while sign(w'*xtrain' -b ) ~= ytrain 
    
 errors=0; 
 for i=1:l           
  
   if sign(xtrain(i,:)*w - b)~= ytrain(i)
     w=w'+(n*ytrain(i))*(xtrain(i,:));               
     b=b-(n*ytrain(i)*(r^2));                   
     errors=errors+1 ; 
     w=w';   
   end
 end
 totalerrors=errors;   
   
end
fprintf("Training Error: %i \n",totalerrors);


%test

[l,p]=size(xtest);
errors=0; 
for i=1:l          
   if ytest(i)~=sign(xtest(i,:)*w-b)
       errors=errors+1;
   end
end
totalerrors=errors;  
fprintf("Test Errors: %i \n",totalerrors);


%plot 

 l=y==0;
 hold on
 plot(x(l,1),x(l,2),'o' );
 plot(x(~l,1),x(~l,2),'o');
 [l,p]=size(x);
 plot([0,1],[0,1],'r-')
 axis([0 1 0 1]), axis square, grid on
 drawnow
