/*  
    ö�ٶ���ξ�����СX����ĵ�S�����������������·�� 
    dp[i,0]��ʾ�ӵ�P�� Y�Ḻ����ֱX�������������ν������Ϊż��������̱߳� 
    dp[i,1]��ʾ�������Ϊ���� 
    Ҫ��ľ��Ǵ�(S,0)��(S,1)�����·�� 
    ʱ�临�Ӷ�O(N^3) 
    ע�⣺����mipt-bbs�ϵ����ۣ���P�����ϸ�λ������������ 
*/

#include <cmath>
#include <vector>
#include <cstdio>
#include <string>
#include <iostream>
using namespace std;

const double eps = 1e-7;
const int maxN = 100 + 5;

/* ���㼸�β��� */
struct Point{
    double x, y;
    Point(){}
    Point(double xx,double yy):x(xx),y(yy){}
};
Point operator - ( const Point & A, const Point & B ){
    return Point( A.x - B.x, A.y - B.y );
}
inline double sqr( const double & x ){
    return x * x ;
}
inline int Compare( const double & x, const double & y ){
    if ( fabs(x - y) <= eps  ) return 0;
    return x < y ? -1 : +1;
}
inline double dist2( const Point & A, const Point & B ){
    return sqr( A.x-B.x ) + sqr( A.y - B.y );
}
inline double det( const Point & A , const Point & B ){
    return A.x  * B.y - B.x * A.y;
}
inline int Cross( const Point & P, const Point & A, const Point & B ){
/*    
    �ж��߶�AB���P�������������ߵĹ�ϵ
    ���� -1 ��ʾ��P��AB�ϣ�������Ҫ��
          0 ��ʾAB�������޽���
          1 ��ʾ�н��� 
*/
    if ( Compare( A.x, B.x ) > 0 ) return Cross( P, B, A );
    double d = det( P - A, B - A );
    if ( fabs(d) <= eps && 
         Compare(A.x, P.x)<=0 && Compare(P.x,B.x)<=0 && 
         Compare(A.y<?B.y, P.y)<=0 && Compare(P.y, A.y>?B.y)<=0 ) return -1;
    if ( Compare( A.x - eps * 10 , P.x ) < 0 && Compare( P.x, B.x - eps * 10 ) < 0 ) // ƽ�� 
        return (d <= eps);
    return 0;
}
/* ���㼸�β��� */



int n, G[maxN*2][maxN*2];
double K, dp[maxN*2];
Point P, A[maxN*2];

double shortest( int start, vector<int> & vd ){     // Dijkstra
    vector<int>::iterator i, j, k;
    bool mk[maxN*2]; memset( mk, 0, sizeof mk);

    for ( i = vd.begin(); i!=vd.end(); i++ ) dp[*i] = 1e20;
    dp[start] = 0;
    
    for ( i = vd.begin(); *i != start; i++ );
    while (1){
        mk[*i] = true;
        k = vd.end();
        for ( j = vd.begin(); j != vd.end(); j++ ){
            if ( mk[*j] ) continue;
            if ( G[*i][*j] >= 0 )
                dp[*j] <?= dp[*i] + sqrt( dist2( A[*i], A[*j] ) );
            if ( k==vd.end() || dp[*j] < dp[*k] )
                k = j;
        }
        if ( k==vd.end() || mk[start+n] ) break;
        i = k;
    }
    
    return ( mk[start + n] ? dp[start + n] : 1e20 );
}

int main(){
    
    freopen("P073.in","r",stdin);
    freopen("P073b.out","w",stdout);
    
    scanf("%d%lf%lf%lf", &n, &K, &P.x, &P.y);
    int i, j, k;
    for ( i = 1; i<=n; i++ )   {
        scanf("%lf%lf", &A[i].x, &A[i].y);
        A[i+n] = A[i];
    }
    
    for ( i = 1; i<=n; i++ ){
        G[i][i] = -1;
        for ( j = i + 1; j<=n; j++ ){
            if ( Compare( dist2( A[i], A[j] ) , K * K ) > 0 )
                G[i][j] = -1; else
                G[i][j] = Cross( P, A[i], A[j] );
            G[j][i] = G[i][j];
        }
    }
/*
    Ϊ�������·��⣬���¶���״̬ 
    (i,0) -> i
    (i,1) -> i + n
    (G[i][j]==1)  => ״̬ i, j �໥�ɴ�
    (G[i][j]==-1) => ״̬ i, j �໥���ɴ�
*/ 
    for ( i = 1; i<=n; i++ )
        for ( j = 1; j<=n; j++ )
            if ( G[i][j]==0 )
                G[i+n][j+n] = G[i][j] = 1, G[i][j+n] = G[i+n][j] = -1; else
            if ( G[i][j]==1 )
                G[i][j+n] = G[i+n][j] = 1, G[i][j] = G[i+n][j+n] = -1; else
                G[i][j+n] = G[i+n][j] = G[i+n][j+n] = -1;

    vector <int> valid;
    vector <int>::iterator ii, kk;
    double ans = 1e20;
    
    for ( int d = 1; d<=n; d++ ) 
        if ( Compare( A[d].x, P.x ) <= 0  ){
            valid.clear();
            for ( i = 1; i<=n; i++ ) 
                if ( Compare( A[i].x, A[d].x ) >= 0 )
                    valid.push_back( i ), valid.push_back( i + n );
            ans <?= shortest( d, valid );
        }
    
    printf("%.2lf\n", ans);
}
