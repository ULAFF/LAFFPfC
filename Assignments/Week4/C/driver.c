#include <stdio.h>
#include <math.h>
#include <time.h>

#include "FLAME.h"

#include "cblas.h"

/* Various constants that control what gets timed */

#define TRUE 1
#define FALSE 0

#define OCTAVE        FALSE

#define A( i,j ) *( ap + (j)*n + (i) )    // map A( i,j ) to array ap in column-major order
#define x( i ) *( xp + i )              // map x( i ) to array xp
#define y( i ) *( yp + i )              // map y( i ) to array yp
#define yold( i ) *( yoldp + i )        // map yold( i ) to array yoldp
#define yref( i ) *( yrefp + i )        // map yold( i ) to array yoldp

void SymMatVec1( int, double *, int, double *, double * );
void SymMatVec2( int, double *, int, double *, double * );
void SymMatVec3( int, double *, int, double *, double * );

int main(int argc, char *argv[])
{
  int n, nfirst, nlast, ninc, i, ii, jj, irep,
    nrepeats;

  double
    dtime, dtime_best, 
    diff;

  double
    *ap, *xp, *yp, *yoldp, *yrefp;
  
  /* Initialize FLAME.  Notice, we will only use the FLAME routines to time the routines  */
  FLA_Init( );

  /* Every time trial is repeated "repeat" times and the fastest run in recorded */
  printf( "%% number of repeats:" );
  scanf( "%d", &nrepeats );
  printf( "%% %d\n", nrepeats );

  /* Timing trials for matrix sizes n=nfirst to nlast in increments 
     of ninc will be performed.  Unblocked versions are only tested to
     nlast_unb */
  printf( "%% enter nfirst, nlast, ninc:" );
  scanf( "%d%d%d", &nfirst, &nlast, &ninc );
  printf( "%% %d %d %d \n", nfirst, nlast, ninc );

  i = 1;
  for ( n=nfirst; n<= nlast; n+=ninc ){

    /* Allocate space for the matrix and vectors */
    ap = ( double * ) malloc( n * n * sizeof( double ) );
    xp = ( double * ) malloc( n * sizeof( double ) );
    yp = ( double * ) malloc( n * sizeof( double ) );
    yoldp = ( double * ) malloc( n * sizeof( double ) );
    yrefp = ( double * ) malloc( n * sizeof( double ) );
    
    /* Generate random matrix A */
    for ( jj=0; jj<n; jj++ )
      for ( ii=0; ii<n; ii++ ){
	A( ii,jj ) = drand48();
      }
   
    /* Generate random vectors x and yold */
    for ( ii=0; ii<n; ii++ ){
      x( ii ) = drand48();
      yold( ii ) = drand48();
    }

    /* Time SymMatVec2 */
    for ( irep=0; irep<nrepeats; irep++ ){
      /* Copy vector yold to yref */
      memcpy( yrefp, yoldp, n * sizeof( double ) );
    
      /* start clock */
      dtime = FLA_Clock();
    
      /* Compute yref = A x + y where A is symmetric stored in the
	 lower triangular part of array A, by calling SymMatVec1.  The
	 result ends up in yrefp, which we will consider to be the correct
         result. */
      SymMatVec1( n, ap, n, xp, yrefp );

      /* stop clock */
      dtime = FLA_Clock() - dtime;
    
      if ( irep == 0 ) 
	dtime_best = dtime;
      else
	dtime_best = ( dtime < dtime_best ? dtime : dtime_best );
    }
  
    printf( "data_SymMatVec1( %d, 1:2 ) = [ %d %le ];\n", i, n,
	    dtime_best );
    fflush( stdout );

    /* Time SymMatVec2 */

    for ( irep=0; irep<nrepeats; irep++ ){
      /* Copy vector yold to y */
      memcpy( yp, yoldp, n * sizeof( double ) );
    
      /* start clock */
      dtime = FLA_Clock();
    
      /* Compute yref = A x + y where A is symmetric stored in the lower triangular part of 
	 array A, by calling SymMatVec2( ) */
      SymMatVec2( n, ap, n, xp, yp );

      /* stop clock */
      dtime = FLA_Clock() - dtime;
    
      if ( irep == 0 ) 
	dtime_best = dtime;
      else
	dtime_best = ( dtime < dtime_best ? dtime : dtime_best );
    }

    diff = 0.0;
    for ( ii=0; ii<n; ii++ )
      if ( dabs( y( ii ) - yref( ii ) ) > diff ) 
	diff = dabs( y( ii ) - yref( ii ) );

    printf( "data_SymMatVec2( %d, 1:3 ) = [ %d %le %le];\n", i, n,
            dtime_best, diff  );

    fflush( stdout );

    /* Time SymMatVec3 */

    for ( irep=0; irep<nrepeats; irep++ ){
      /* Copy vector yold to y */
      memcpy( yp, yoldp, n * sizeof( double ) );
    
      /* start clock */
      dtime = FLA_Clock();
    
      /* Compute yref = A x + y where A is symmetric stored in the lower triangular part of 
	 array A, by calling SymMatVec3( ) */
      SymMatVec3( n, ap, n, xp, yp );

      /* stop clock */
      dtime = FLA_Clock() - dtime;
    
      if ( irep == 0 ) 
	dtime_best = dtime;
      else
	dtime_best = ( dtime < dtime_best ? dtime : dtime_best );
    }

    diff = 0.0;
    for ( ii=0; ii<n; ii++ )
      if ( dabs( y( ii ) - yref( ii ) ) > diff ) 
	diff = dabs( y( ii ) - yref( ii ) );

    printf( "data_SymMatVec3( %d, 1:3 ) = [ %d %le %le];\n", i, n,
            dtime_best, diff  );

    fflush( stdout );
    
    free( ap );
    free( xp );
    free( yp );
    free( yoldp );
    free( yrefp );

    i++;
}


  FLA_Finalize( );

  exit( 0 );
}
