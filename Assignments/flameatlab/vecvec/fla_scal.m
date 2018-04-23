function [ x_out ] = fla_scal( alpha, x )
% Computes x_out = alpha * x
%   Vector x can be a column or row vector.
%   Scalar alpha must be a scalar.

% Make sure alpha is a scalar
assert( isscalar( alpha ), 'alpha must be a scalar' );

% Make sure x is a vector
assert( isvector( x ), 'x must be a vector' );

x_out = alpha * x;

end
