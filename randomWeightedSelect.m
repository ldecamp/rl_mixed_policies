function [ solution ] = randomWeightedSelect( weights, twist )
% Returns an index at "random" from 1 to length(weights) with
% probabilities in analogy to each index's weight(index).
% 'twist ~= 0' forces the resetting of the random number generator.

% fprintf(['weights value: ', num2str(weights),'\n']);
if nargin == 2
    fprintf(['twist value: ', num2str(twist),'\n']);
    if twist
        %Is it to reset the seed for random generation number?
        %What effect?
    	rand('twister',sum(100*clock)) ;
    end % if
end % if

%normalise weights
weights = weights/sum(weights) ;

%here is it the same as data samples with weights?

randomRoll = rand() ;
N_of_Options = length(weights) ;
solution = 0 ;
solutionFound = 0 ;
sums = 0 ;
i = 1 ;

while i <= N_of_Options && ~solutionFound
    sums = sums + weights( i ) ;
    if randomRoll <= sums
        solution = i ;
        solutionFound = 1 ;
    end % if
    i = i + 1 ;
end % while
