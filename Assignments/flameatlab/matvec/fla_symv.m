function [ y_out ] = fla_symv( uplo, alpha, A, x, beta, y )

% fla_symv( uplo, alpha, A, x, beta, y )
%    Computes y_out = alpha * A * x + beta * y.
%    if uplo = 'Lower triangular', the symmetric matrix A is stored
%    in the lower triangular part of A
%    if uplo = 'Upper triangular', the symmetric matrix A is stored
%    in the upper triangular part of A

% Check parameters

% Check if uplo is 'Lower triangular' or 'Upper triangular'
assert(isequal( uplo, 'Lower triangular' ) || ...
       isequal( uplo, 'Upper triangular'), ...
       'syr: illegal uplo parameter' )

% Check if alpha is a scalar
assert( isscalar( alpha ), 'gemv: alpha is not a scalar' );
% Check if beta is a scalar
assert( isscalar( beta ), 'gemv: beta is not a scalar' );

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
% if y is a row vector, we make it a column vector (but remember what it
% was so that y_out is set to be a row or column vector, at the end)
if n_y ~= 1
    y = y';
    m_y = n_y;
    y_is_a_row = 1;
else
    y_is_a_row = 0;
end

% make sure that all the sizes match up
assert( m_A == n_A, 'symv: A must be square' );
assert( m_A == m_x, 'symv: size of x doesnt match' );
assert( m_A == m_y, 'symv: size of y doesnt match' );

% Make A symmetric
if isequal( uplo, 'Lower triangular' )
    A = tril( A ) + tril( A, -1 )';
else
    A = triu( A ) + triu( A, 1 )';
end

y_out = alpha * A * x + beta * y;

if y_is_a_row
    y_out = y_out';
end

end

