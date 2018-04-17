function [ L, U, P ] = luFactor(A)
% luFactor: A function that determines the LU Factorization of a square
% matrix (A).
%   This function uses partial pivoting to avoid division by zero in the
%   Guass Elimination step of the algorithm. 
% Inputs: 
% A - The matrix of coefficients from the system of equations. 
% Outputs: 
% U - The upper triangle matrix achieved after Gauss Elimination is
% performed. 
% L - The lower "factor" matrix containing the factors used to eliminate
% variables from the matrix A.
% P - The identity matrix used to keep track of pivoting performed on A.
clear
if nargin < 1 %checks if there are not enough inputs
    warning('Not enough input arguments') 
end 
if nargin > 1 
    warning('Too many input arguments') %checks if there are too many inputs
end
A = [2 -6 -1 5;-3 -1 7 5;-8 1 -2 5]%for testing
[n m]=size(A); %assigns the dimensions of the square matrix to row and col
if n~=m
    warning('Matrix must be square')
end
P=eye(n)%creates a identity matrix with same dimensions as A
L=eye(n)%creates the L identity matrix
[B,I]=sort(abs(A(:,1)),'descend')%sorts the first colum of the abs val matrix in descending order and assigns order to I
A2=A(I,:)%creates a new matrix with rows in order of I, as defined above
P=P(I,:)%pivots the identity matrix to reflext the pivot done on A
d=0;%initializes d for later index of denomenator
for b=1:n-1%creates an index for the number of colums to step through(minus one because the last column is not applicable)
    t=A2(b,:)
    d=d+1
for i=1:n-1 %creates an index for the number of rows to step through
    if A2(i+1,b)/A2(d,b)==0%checks if any of the coefficients are zero 
    break%if so, the first for loop is broken and the process moves on to the next column
    end 
    if b>1 
        [B,I]=sort(abs(A2(b:n,b)),'descend')%sorts the first colum of the abs val matrix in descending order and assigns order to I
        A2(b:n,:)=A2(I+d-1,:)%creates a new matrix with rows in order of I, as defined above
        P(b:n,:)=P(I,:)%pivots the identity matrix to reflext the pivot done on A
    end
    f=A2(i+1,b)/t(1,b)%devides lower coefficient by upper coefficient to get factor
    L(i+1,b)=f%stores the factor in the L matrix
    E=(t).*f%multiplies the top row by the factor
    A2(i+1,:)=(A2(i+1,:))-E%replaces the row of A2 that was eliminated with the new row
    
    
    
end
end
    
 

end

