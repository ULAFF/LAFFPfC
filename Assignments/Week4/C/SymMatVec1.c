#define A( i,j ) *( ap + (j)*lda + i )  // map A( i,j ) to array ap in column-major order
#define x( i ) *( xp + i )              // map x( i ) to array xp
#define y( i ) *( yp + i )              // map y( i ) to array yp


void SymMatVec1( int n,
		 double *ap,
		 int lda,
		 double *xp,
		 double *yp )
{
  int i, j;

  for ( i=0; i<n; i++ ){
    for ( j=0; j<=i; j++ )
      y( i ) += A( i, j ) * x( j );
    for ( j=i+1; j<n; j++ )
      y( i ) += A( j, i ) * x( j );
  }

  return;
}
  
