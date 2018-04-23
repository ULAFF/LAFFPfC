function [ A_out ] = fla_syr( uplo, alpha, x, A )

% fla_syr( uplo, alpha, x, A )
%    Computes A_out = alpha * x * x' + A.
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

% Make sure x is a vector
assert( isvector( x ), 'x must be a vector' );

[ m_A, n_A ] = size( A );
[ m_x, n_x ] = size( x );

% Now we cheat a little: 
% if x is a row vector, we make it a column vector
if n_x ~= 1
    x = x';
    m_x = n_x;
end

% make sure that all the sizes match up
assert( m_A == n_A, 'syr: A must be square' );
assert( m_A == m_x, 'syr: size of x doesnt match' );

% Make A symmetric
if isequal( uplo, 'Lower triangular' )
    A_out = alpha * tril( x * x' ) + A;
else
    A_out = alpha * triu( x * x' ) + A;
end

end

