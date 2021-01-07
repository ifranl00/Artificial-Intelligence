function indices_folds = crear_k_fold(Y, k)
% Esta función crea un vector (matriz fila) con tantos elementos como
% patrones que contiene el índice del fold en el que estará el correspondiente
% patrón. Esta asignación se realiza aleatoriamente.
% Es decir, en la posición i-ésima del vector indices_folds estará el número 
% de fold (ENTRE 1 Y K) en el que estará el patrón i-ésimo. LA FUNCIÓN ESTÁ
% DISEÑADA PARA PROBLEMAS DE DOS CLASES.
%
% INPUT
%   - Y: Vector que indica las clases de los patrones.
%   - k: Número de folds que hay que generar.
%
% OUTPUT
%   indices_folds: vector (matriz fila) con la misma longitud que Y. 
%   Contiene el índice del fold en el que estará el correspondiente patrón.
%   Es decir, en la posición i-ésima del vector de salida estará el número 
%   de fold en el que estará el patrón i-ésimo.
%


 	nPorClase = length(Y)/k;
     modulo = mod(length(Y),k);
    v = [];
    for i=1:nPorClase
       v = horzcat(v, randperm(k)); %%concatena el trozo con el anterior y randperm, hace un random con permutaciones
    end
    
   if(modulo ~= 0)
     
        v = horzcat(v, randperm(modulo));
        
    end
       indices_folds = v;


%     m = zeros(1,length(Y));
%         
%         for i=1:length(Y)
%            p = 0;
%            
%            while(p == 0)
%                r = randi([1 k],1,1); %%randi: aleatorios 
%                en = find(m==r); 
%                nRepetido = length(en);
%                if((nRepetido < nPorClase))
%                   element = modulo;
%                   while(element ~=0)
%                       m(i) = r;
%                       element = element-1;
%                   end
%                
%                    m(i)=r;
%                    p = 1;
%            end
%         end

count0 = 1;
count1 = 1;

inds0=find (Y==0);
inds1=find (Y==1);
           clase0 = mod(randperm(length(inds0)),k)+1;%% se suma 1 porque va desde 0 hasta k-1
           clase1 =mod(randperm(length(inds1)),k)+1;
           for i = 1 : length(Y)
               if Y(i) == 0
                   indices_folds(i) = clase0(count0);
                   count0 = count0 + 1;
               elseif Y(i) ==1
                    indices_folds(i) = clase1(count1);
                   count1 = count1 + 1;
               end
           end
           
           
end


