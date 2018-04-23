function [ x_out ] = fla_invscal( alpha, x )
% Computes x_out = 1/alpha * x
%   Vector x can be a column or row vector.
%   Scalar alpha must be a scalar.

% Make sure alpha is a scalar
assert( isscalar( alpha ), 'alpha must be a scalar' );

% Make sure x is a vector
assert( isvector( x ), 'x must be a vector' );

x_out = (1/alpha) * x;

end
