function [ A_out ] = fla_ger( alpha, x, y, A )

% fla_ger( alpha, x, y, A )
%    computes alpha * x * y' + A
%    but it is a bit tricky: x and y can be row or column vectors, in any
%    combination.

% Check if alpha is a scalar
assert( isscalar( alpha ), 'ger: alpha is not a scalar' );

% Make sure x and y are (row or column) vectors
assert( isvector( x ), 'x must be a vector' );
assert( isvector( y ), 'y must be a vector' );

[ m_A, n_A ] = size( A );
[ m_x, n_x ] = size( x );
[ m_y, n_y ] = size( y );

% Now we cheat a little: 
% if x is a row vector, we make it a column vector
if n_x ~= 1
    x = x';
    m_x = n_x;
end
% if y is a row vector, we make it a column vector 
if n_y ~= 1
    y = y';
    m_y = n_y;
end

assert( m_A == m_x && n_A == m_y, ['ger: sizes of A, x, and/or ' ...
                        'y do not  match'] );
A_out = alpha * x * y' + A;

end
