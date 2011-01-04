#include <vector>
#include <list>
#include <map>
#include <set>
#include <queue>
#include <deque>
#include <stack>
#include <bitset>
#include <algorithm>
#include <functional>
#include <numeric>
#include <utility>
#include <sstream>
#include <iostream>
#include <iomanip>
#include <cstdio>
#include <cmath>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <queue>
using namespace std;
#define   max(a,b)    ((a)>(b)?(a):(b))
#define   min(a,b)    ((a)<(b)?(a):(b))
#define   sqr(a)         ((a)*(a))
#define   rep(i,a,b)  for(i=(a);i<(b);i++)
#define   REP(i,n)     rep(i,0,n)
#define   clr(a)      memset((a),0,sizeof (a));
#define   mabs(a)     ((a)>0?(a):(-(a))) 
#define   inf         1000000000
#define  MAXM     1000
#define  MAXN     21
#define  eps      1e-6
#define  MOD      50261
int N,M,D;
int a[MAXN][MAXN][MAXN];
int b[MAXN][MAXN];
int c[MAXN][MAXN];
int chuli()
{
	clr(c);
	int i,j,k,p;
	rep(i,1,M+1) rep(j,1,N+1)
	{
		c[i][j]=c[i-1][j]+c[i][j-1]-c[i-1][j-1]+b[i-1][j-1];
	}
	int tret=-inf;
	REP(i,M+1) REP(j,i) REP(k,N+1) REP(p,k) tret=max(tret,c[i][k]-c[i][p]-c[j][k]+c[j][p]);
	return tret;
}
int main()
{
    int i,j,k,p,q;
    scanf("%d%d%d",&M,&N,&D);
	int ret=-inf;
	REP(i,D) REP(j,M) REP(k,N) scanf("%d",&a[i][j][k]);
	REP(i,D+1)
		REP(j,i)
	{
		 REP(k,M) REP(p,N)
		 {
			 b[k][p]=0;
			 rep(q,j,i) b[k][p]+=a[q][k][p];
		 }
         int tret=chuli();
		 ret=max(tret,ret);
	}
	printf("%d\n",ret);
    return 0;
}

