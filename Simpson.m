function [I] = Simpson(x,y)
%Simpson - A function that utilizes the composite simpsons 1/3 rule and the trapezoidal rule to approximate
%the integral of data points. 
%   Andrew Kollar
%   April 5th, 2018
%   The function evaluates the integral of the vector of a function values
%   'y' with respect to 'x'. If the number of data points is even, the
%   trapezoidal rule is utilized for the last interval. 
% Outputs:
% I - The approximate numerical value of the integral
% Inputs: 
% x - The vector containing the x values of the function
% y - The vector containing the y values of the function
if nargin < 2 %checks if there are too few arguments
    error('Not enough input arguments')
end
if nargin > 2 %checks if there are too many arguments
    error('Too many input arguments')
end 
if nargout ~= 1 %checks if the user asks for too many outputs
    error('Too many requested outputs, there is only one output')
end
xl = length(x);%checks the size of the x vector
yl = length(y);%checkss the size of the y vector
if xl ~= yl%checks if the x and y vectors are the same length
    error('x and y vectors must be the same length')
end 
diff_x = diff(x);%creates a vector with one less element than x that contians the differences between values
if max(diff_x) ~= min(diff_x)%makes sure all the values in the difference vector are equall to 
    error('x vector must have even spacing between elements')
end
m = mod(xl,2);
if m == 0% even number of points
    warning('The trapezoidal rule will be used on the last interval')
end
h = x(end)-x(1);
if m == 1 % odd number of points
    even = sum(y(2:2:yl-1));%summing the values of y that correspond to the even index values 
    odd = sum(y(3:2:yl-1));%summing the values of y that correspond to the odd index values
    I = (h).*(y(1)+(4.*even)+(2.*odd)+y(end))./(3.*(xl-1));%using the 1/3 rule to evaluate the integral
end 
if m == 0 % even number of points
    even = sum(y(2:2:yl-2));%summing the values of y that correspond to the even index values
    odd = sum(y(3:2:yl-2));%summing the values of y that correspond to the odd index values
    Is = (h).*(y(1)+(4.*even)+(2.*odd)+y(end))./(3.*(xl-1));%evaluating the 1/3 rule
    htrap = x(xl)-x(xl-1);%calculating the size of the interval for the trapezoidal rule
    trap = (htrap).*((y(xl-1)+y(xl))./(2));%evaluating the trapezoidal rule 
    I = Is + trap;%adding the values from both estimation methods
end    
end

