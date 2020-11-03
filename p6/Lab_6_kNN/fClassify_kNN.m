function Y_assign = fClassify_kNN(X_train, Y_train, X_test, k)
% This function implements the kNN classification algorithm with the
% eucludean distance
%
% INPUT
%   - X_train: Matrix (n_train x m), where n_Train is the number of 
%   training elements and n is the number of features (the length of the 
%   feature vector)
%   - Y_train: The classes of the elements in the training set. It is a
%   vector of length n_train with the number of the class.
%   - X_test: matrix (n_test x n), where n_test is the number of elements 
%   in the test set.
%   - k: Number of nearest neighbours to consider in order to make an
%   assignation
%
% OUTPUT
%   A vector with length n_test, with the classess assigned by the algorithm 
%   to the elements in the training set.
%

    numElemTest = size(X_test, 1);
    numElemTrain = size(X_train, 1);

    % Allocate space for the output
    Y_assign = zeros(1, numElemTest);
    
    % for each element in the test set...
    for i=1:numElemTest
        
        x_test_i = X_test(i,:);
        
        % 1 - Compute the Euclidean distance of the i-th test element to 
        % all the training elements
        % ====================== YOUR CODE HERE ======================
        
        dist = pdist2(x_test_i,X_train,'euclidean');

        % ============================================================
        
        % 2 - Order distances in ascending order and use the indices of the 
        % ordering
        % ====================== YOUR CODE HERE ======================
        [dis_ord, inds] = sort(dist);
        % ============================================================

        % 3 - Take the k first classes of the training set
        % ====================== YOUR CODE HERE ======================
         classElement = Y_train(inds(1,1:k));
        % ===========================================================
        
        % 4 - Assign to the i-th element the most frequent class
        % ====================== YOUR CODE HERE ======================
        pos1 = find(classElement); %%encuentra los indices de los que son 1
        pos0 = find(classElement == 0); %%encuentra los indices de los que son 0
        
        if length(pos1) > length(pos0)
            Y_assign(1,i)= 1;
        else 
            Y_assign(1,i)= 0;
        end
        % ============================================================
    end

end

