function [ y_out ] = fla_gemv( trans, alpha, A, x, beta, y )

% fla_gemv( trans, alpha, A, x, beta, y )
%    if trans = 'No transpose' returns alpha * A  * x + beta * y
%    if trans = 'Transpose'    returns alpha * A' * x + beta * y

% Check parameters

% Check if trans is 'No transpose' or 'Transpose'
assert(isequal( trans, 'No transpose' ) || ...
       isequal( trans, 'Transpose' ), 'illegal trans parameter' ); 

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

if isequal( trans, 'No transpose' )
    assert( n_A == m_x && m_A == m_y, ['gemv: sizes of A, x, and/or ' ...
                        'y do not  match'] );
    y_out = alpha * A * x + beta * y;
else
    assert( m_A == m_x && n_A == m_y, ['gemv: sizes of A, x, and/or ' ...
                        'y do not match'] ) 
        y_out = alpha * A' * x + beta * y;
end

if y_is_a_row
    y_out = y_out';
end

end

