#define A( i,j ) *( ap + (j)*lda + i )  // map A( i,j ) to array ap in column-major order
#define x( i ) *( xp + i )              // map x( i ) to array xp
#define y( i ) *( yp + i )              // map y( i ) to array yp


void SymMatVec3( int n,
		 double *ap,
		 int lda,
		 double *xp,
		 double *yp )
{
  int i, j;
  
  for ( j=0; j<n; j++ ){
    y( j ) += A( j,j ) * x( j );		\
    for ( i=j+1; i<n; i++ ){
      y( i ) += A( i,j ) * x( j );		\
      y( j ) += A( i,j ) * x( i );
    }
  }

  return;
}
  
