    #include <map>
    #include <set>
    #include <list>
    #include <cmath>
    #include <queue>
    #include <stack>
    #include <bitset>
    #include <vector>
    #include <cstdio>
    #include <string>
    #include <sstream>
    #include <cstdlib>
    #include <cstring>
    #include <iostream>
    #include <algorithm>
    using namespace std;
    int N , M , G[ 20 ] , A[ 20 ] , P[ 20 ] ;
    long long K , F[ 70000 ] ;

    inline int Pos( int s , int k )
    {
            return ( s >> k ) & 1 ;
    }

    inline long long Calc( int s , int k )
    {
            if ( F[ s ] != -1 ) return F[ s ] ;
            if ( k == N ) return F[ s ] = 1 ;
            F[ s ] = 0 ;
            for ( int i = 0 ; i < N ; i ++ )
            if ( Pos( s , i ) == 0 && ( s & G[ i ] ) == 0 && Pos( P[ k ] , i ) == 1 && Pos( A[ i ] , k ) == 1 ) {
                    F[ s ] += Calc( s | ( 1 << i ) , k + 1 ) ;
            }
            return F[ s ] ;
    }

    inline int Print( int s )
    {
            for ( int i = 0 ; i < N ; i ++ )
            if ( Pos( s , i ) == 1 ) return i + 1 ;
            return -1 ;
    }

    int main()
    {
            cin >> N >> K >> M ;
            for ( int i = 0 , a , b ; i < M ; i ++ ) {
                    cin >> a >> b ;
                    G[ a - 1 ] |= 1 << ( b - 1 ) ;
            }
            M = ( 1 << N ) - 1 ;
            for ( int i = 0 ; i < N ; i ++ )
                    A[ i ] = P[ i ] = M ;
            memset( F , -1 , sizeof( F ) ) ;
            Calc( 0 , 0 ) ;
            K -= 2000 ;
            if ( F[ 0 ] < K ) {
                    printf( "The times have changed\n" ) ;
                    return 0 ;
            }
            for ( int i = 0 ; i < N ; i ++ ) {
                    for ( int j = 0 ; j < N ; j ++ )
                    if ( P[ j ] == M ) {
                            A[ i ] = 1 << j ;
                            P[ j ] = 1 << i ;
                            memset( F , -1 , sizeof( F ) ) ;
                            Calc( 0 , 0 ) ;
                            if ( F[ 0 ] < K ) {
                                    K -= F[ 0 ] ;
                                    A[ i ] = M ;
                                    P[ j ] = M ;
                            } else {
                                    break ;
                            }
                    }
            }
            printf( "%d" , Print( A[ 0 ] ) ) ;
            for ( int i = 1 ; i < N ; i ++ )
                    printf( " %d" , Print( A[ i ] ) ) ;
            printf( "\n" ) ;
            return 0 ;
    }