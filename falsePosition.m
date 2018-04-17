
function [ root, fx, ea, iter ] = falsePosition( func, xl, xu, es, maxiter )
%falsePosition - Estimates roots using false position. NOTE: USER MUST type "@(x)" 
%   followed by one space INSIDE falsePosition before they type the function (func).  
%   This fuction estimates the root of any function given by the user. This
%   function cannot estimate more than one root in the same itteration. 
%   If there are multiple roots or no roots in the window specified by the
%   user, this function will return an error. 

% NOTE: THIS IS VERY IMPORTANT
% THE USER MUST type "@(x)" followed by one space INSIDE falsePosition before they type the
% function (func).  

% Inputs:
% func - The fuction whose roots are being estimated

% xl - The lower guess of the root
% xu - The upper guess of the root
% es - the desired relative error (default: 0.0001%)
% maxiter - The number of itterations desired (default: 200)

% Outputs:
% root - The estimated root location
% fx - The function evaluated at the root location
% ea - The approximate relative error
% iter - how many itterations were performed


if nargin < 3 
    warning('Not enough input arguments, you need at least 3')
end 
% checks the number of input arguments to make sure there is at least 3.

if nargin == 3
    es = 0.0001;
    maxiter = 200;
end
% If the user inputs only the function, the lower estimate, and the upper
% estimate, then the default relative error is 0.0001 and the max number of
% itterations is 200

if nargin == 4
    maxiter = 200;
end
% If the user inputs only the function, the lower estimate, the upper
% estimate, and the relative error, then the default max number of
% itterations is 200

f = func;
% This simply renames the function inputed to 'f' for simplification

ea = 100;
% This sets the approximate relative error at 100 percent for the fist root
% estimate

root = zeros(1,1000);
% This pre-allocates storage for the estimated roots. On each itteration,
% the estimated root is stored in this matrix.

iter = 1;
% This initializes the value of iter at one before begining the estimation
% process.

while ea > es
% this loop will run as long as the estimated percent relative error is
% greater than the user specified percent relative error.  
    
    if f(0) == 0
        root = 0;
        break
    end 
    % The purpose of this loop is to test if the root is at zero. If it is,
    % the estimated process will be terminated.
    
    if f(xu)*f(xl) > 0
    error('Invalid window. There are either multiple roots, or no roots in your window. Try graphing your function and picking a different window.');
    end 
    % An error will be returned if the function does not cross the x axis
    % in the window specified by the user. 
    
    
        xu=xu;
        xl=xl;
        fxu = f(xu);
        fxl = f(xl);
        % this chunk creates variables for the function evaluated at the
        % upper and lower estimates.

        root(iter) = xu-((fxu*(xl-xu))/(fxl-fxu));
        % this calculates the root using flase position 

            if f(root(iter))*f(xu) > 0
                xu = root(iter);
                xl=xl;
            end 
            % This checks if there is a sign change between the root and
            % the upper estimate. If there is no sign change, the root
            % becomes the upper estimate.
            if f(root)*f(xl) > 0
                xl = root(iter); 
                xu=xu;
            end 
            % This checks if there is a sign change between the root and
            % the lower estimate. If there is no sign change, the root
            % becomes the lower estimate.
            
            if iter > 1
            ea = abs(((root(iter)-root(old))/(root(iter)))*100);
            end 
            % This calculates the percent relative error between the most
            % recent root estimation and the last root estimation for
            % itterations greater than one. (becuse on the first estimation
            % the error is set to 100%)

            if iter == 1
                ea = 100;

            end 
            if iter == maxiter
                break
            end
            % This will end the estimation process if the number of
            % itterations is greater than the max number of itterations
            % specified by the user. 
            if ea > es
            old=iter;
            iter = iter + 1;
            end 
            % as long as the estimated error is greater than the specified
            % error, another itteration will be performed, and the last
            % itteration is stored as "old" so that the percent relative
            % error can be calculated on the next itteration. 

end 
root = root(iter);
% This defines the root at the root estimated on the last itteration. 
fx = f(root);
% This evaluates the function at the estimated root. 



end

