function [ y ] = fla_trsv( uplo, trans, diag, A, x )

% fla_trsv( uplo, trans, diag, A, y )
%    fla_trsv( 'Lower triangular', 'No transpose', 'Nonunit diag', A, y )
%        computes y := tril( A ) \ x
%    fla_trsv( 'Upper triangular', 'Transpose', 'Nonunit diag', A, y )
%        computes y = triu( A )' \ x 
%    fla_trsv( 'Lower triangular', 'No transpose', 'Unit diag', A, y )
%        computes y = tril( A ) \ x except with (implicitly) ones on the
%        diagonal.  

% Check parameters

% Check if uplo is 'Lower triangular' or 'Upper triangular'
assert(isequal( uplo, 'Lower triangular' ) || ...
       isequal( uplo, 'Upper triangular'), ...
       'trsv: illegal uplo parameter' );

% Check if trans is 'No transpose' or 'Transpose'
assert(isequal( trans, 'No transpose' ) || ...
       isequal( trans, 'Transpose' ), ...
       'trsv: illegal trans parameter' );

% Check if diag is 'Nonunit diag' or 'Unit diag'
assert (isequal( diag, 'Nonunit diag' ) ||...
        isequal( diag, 'Unit diag'), ...
        'trsv: illegal diag parameter' );

% Check if x is a (row or column) vector
assert (isvector( x ), 'trsv: x is not a vector' );

[ m_A, n_A ] = size( A );
[ m_x, n_x ] = size( x );

% Now we cheat a little: 
% if x is a row vector, we make it a column vector (but remember what it
% was so that x is set to be a column or row vector, at the end)
if n_x ~= 1
    x = x';
    m_x = n_x;
    x_is_a_row = 1;
else
    x_is_a_row = 0;
end

% Check that A is square and th size of (the updated) x is the same as the
% size of A.
assert( m_A == n_A && m_A == m_x, 'trsv: A and/or x do not have same size' );

% Now lets fix A
if isequal( uplo, 'Lower triangular' )
    if isequal( diag, 'Nonunit diag' )
        A = tril( A );
    else
        A = tril( A, -1 ) + eye( size( A ) );
    end
else
    if isequal( diag, 'Nonunit diag' )
        A = triu( A );
    else
        A = triu( A, 1 ) + eye( size( A ) );
    end
end

if isequal( trans, 'Transpose' )
    A = A';
end

% Now use matlab's intrinsic method for computing y = A x 
y = A \ x;

% And fix the return to be consistent with y
if x_is_a_row
    y = y';
end

end

