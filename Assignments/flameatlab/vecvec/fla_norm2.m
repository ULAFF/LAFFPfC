function [ alpha_out ] = fla_norm2( x )
% Computes the two-norm or x.
%   Vector x can be a column or row vector.

% Extract the row and column sizes of x
[ m_x, n_x ] = size( x );

% Make sure alpha is a scalar
assert( isscalar( alpha ), 'alpha must be a scalar' );

% Make sure x is a vector
assert( isvector( x ), 'x must be a vector' );

alpha_out = norm( x )

end
