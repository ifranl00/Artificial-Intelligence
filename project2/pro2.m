clc
close all
%import our Calculate Data
load data.mat;

% **************************TRAIN*****************************

fprintf('\n');
fprintf('**********************************************************************\n');
fprintf('******************************** TRAIN *******************************\n');
fprintf('**********************************************************************\n');
fprintf('\n');

tic
[l,p]=size(x);
w=[max(max(x));0]; %I start with the max value from w equeal to the max x in the data given.
b=0;            
n=0.9;        %LEARNING RATE
r=max(sqrt(sum(x))); 
iteration=1;
SumErrors=0;
TotalError=1;

    %TRAIN CODE
while TotalError~=0 %Repeat while the algorith is not correctly trained.
 
    for i=1:l  %repeat for each element(20) 
    
        %Plot bias and Weight value from each iteration.
        figure(80);
        subplot(3,1,1);
        hold on;
        title('Bias')
        ylabel('Bias Value');
        xlabel('Iterations');
        totalIteration= 20*(iteration-1)+i;
        plot(totalIteration,b,'b.'); 
        grid on

        subplot(3,1,2);
        hold on;  
        title('Weight x')
        ylabel('Weight x Value');
        xlabel('Iterations');
        plot(totalIteration,w(2),'b.'); 
        grid on

        subplot(3,1,3);
        hold on;  
        title('Weight y')
        ylabel('Weight y Value');
        xlabel('Iterations');
        plot(totalIteration,w(1),'b.'); 
        grid on

   
       if sign(x(i,:)*w - b)~= y(i) %if the perceptron is wrong, then change value from w and b
           w=w'+n*y(i)*(x(i,:));               
           b=b-n*y(i)*(r^2);                   
           w=w';   
       end
    end
 
   %TEST CODE
   
   TP = 0; %True positive
   TN = 0; %True Negative
   FP = 0; %False Positive
   FN = 0; %False Negative
    
   %For each iteration generate an individual graph when we can see the
   %value from W and the errors  
   figure(iteration);
   hold on;
   title('Binary classification')
   ylabel('y');
   xlabel('x');
   
    for i=1:l          
       if y(i)~=sign(x(i,:)*w-b) %If is wrong
           if y(i)== -1 %the result must we negative and the perceptron return positive, so we have an False Positive
              FP = FP + 1;
              plot(x(i,1),x(i,2),'r+' ); %%PLOT AN False positive
           else %the result must we positive and the perceptron return negative, so we have an False Negative
              plot(x(i,1),x(i,2),'r_' ); %%PLOT AN False Negative
              FN = FN + 1;
           end
       else %If the perceptron have a good prediction
          
           if y(i)== -1 %If the result is negative It is a True Negative
               plot(x(i,1),x(i,2),'g_' );
               TN = TN +1;
           else     %If it is positive is a True Positive
               TP = TP +1;
               plot(x(i,1),x(i,2),'g+' );
           end

       end
    end

    plot([0,(w(2))],[0,(w(1))],'r-') %plot the Weight line
    axis([-2 2 -2 2]), axis square, grid on
    drawnow
    
    TotalError= FP+FN;
    SumErrors= SumErrors+TotalError;
    accuracie = (TP+TN)/(TP+TN+FP+FN);
 
    fprintf('\n');
    fprintf('***************** ITERATION %d ******************\n',iteration);
    fprintf('\n');
    fprintf("False Negative: %i \nFalse Positive: %i  \n",FN,FP);
    fprintf("True Negative: %i \nTrue Positive: %i   \n",TN,TP);
    fprintf("\nTotal Errors in this iteration: %i \n",TotalError);

    fprintf('ACCURACY = %4.2f \n', accuracie);
    fprintf('\n');
    iteration= iteration+1;
    

end

fprintf("\nErrors in TOTAL: %i \n",SumErrors);
toc

 