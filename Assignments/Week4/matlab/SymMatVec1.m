function [ y_out ] = SymMatVec1( A, x, y )
% Compute y := A x + y, assuming A is symmetric and stored in lower
% triangular part of array A.

% Extract the row and column size of A
[ m, n ] = size( A );

% (Strictly speaking you should check that m = n, x is a vector size n and y is a
% vector of size n...)

% Copy y into y_out
y_out = y;

% Compute y_out = A * x + y_out
for i = 1:n
    for j=1:i
        y_out( i ) = A( i,j ) * x( j ) + y_out( i );
    end
    for j=i+1:n
        y_out( i ) = A( j,i ) * x( j ) + y_out( i );
    end
end

end

