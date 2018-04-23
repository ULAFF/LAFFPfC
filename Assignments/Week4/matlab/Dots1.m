function [ alpha_out ] = Dots1( x, y, alpha )
% Update alpha with the dot product of vectors x and y
%   alpha_out = ( SUM k | 1 <= k <= m : x( k ) * y( k ) ) + alpha
%   where m = size( x, 1 ) = size( y, 1 )
%   
%   Input
%   x     - column vector x  ( m x 1 )
%   y     - column vector y  ( m x 1 )
%   alpha - scalar alpha
%   
%   Output
%   alpha_out - updated scalar alpha

% Check that x and y are vectors, that alpha is a scalar, and that the 
% sizes of x and y are equal.

assert( isvector( x ) && size( x, 2 ) == 1, ...
    'x is not a column vector' );
assert( isvector( x ) && size( y, 2 ) == 1, ...
    'y is not a column vector' );
assert( isscalar( alpha ), 'alpha must be a scalar' );
m_x = size( x, 1 );
m_y = size( y, 1 );
assert( m_x == m_y , 'x and y must be of same length' );

i = 1;
while i<=m_x 
    alpha = x( i ) * y( i ) + alpha;
    i = i+1;
end

alpha_out = alpha;

end

