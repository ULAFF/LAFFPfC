function [ alpha_out ] = fla_dots( x, y, alpha )
% Computes the dot product of vectors x and y and adds it to alpha.
%   Vectors x and y can be a mixture of column and/or row vector.
%   In other words, x and y can be n x 1 or 1 x n arrays.  However,
%   one size must equal 1 and the other size equal n.  
%   Scalar alpha must be a scalar.

% Extract the row and column sizes of x and y
[ m_x, n_x ] = size( x );
[ m_y, n_y ] = size( y );

% Make sure alpha is a scalar
assert( isscalar( alpha ), 'alpha must be a scalar' );

% Make sure x and y are (row or column) vectors of equal size
assert( isvector( x ), 'x must be a vector' );
assert( isvector( y ), 'y must be a vector' );
assert( ( m_x * n_x == m_y * n_y ), 'x and y must be of same size' );

if ( n_x == 1 )     % x is a column vector
    if ( n_y == 1 )     % y is a column vector
        alpha_out = alpha + x' * y;
    else     % y is a row vector
        alpha_out = alpha + x' * y';
    end
else    % x is a row vector
    if ( n_y == 1 )     % y is a column vector
        alpha_out = alpha + x * y;
    else     % y is a row vector
        alpha_out = alpha + x * y';
    end
end

end
