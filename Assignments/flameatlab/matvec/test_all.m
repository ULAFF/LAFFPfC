x3 = randi( [-2,2], [3,1] );
x4 = randi( [-2,2], [4,1] );
y3 = randi( [-2,2], [3,1] );
y4 = randi( [-2,2], [4,1] );
alpha = 2;
beta = 3;

A = randi( [-2,2], [4,4] ) + 4 * eye( 4, 4);

disp('Should work')
fla_trsv( 'Lower triangular', 'Transpose', 'Unit diag', A, x4 ) -...
    ( (tril( A, -1 )+eye( 4,4 ))' \ x4 )

% A = randi( [-2,2], [4,3] );

disp('Should not work')
fla_trsv( 'Lower triangular', 'Transpose', 'Unit diag', A, x3 ) -...
    ( (tril( A, -1 )+eye( 4,4 ))' \ x4 )



