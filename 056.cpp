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
#define  MAXN     20
#define  eps      1e-6
#define  MOD      50261
int N,M;
typedef struct node 
{
	double x;
	double y;
}node;
node pt[MAXN];
double dp[1<<MAXN];
int bitcnt[1<<MAXN];
double getdis(int i,int j)
{
	return sqrt(sqr(pt[i].x-pt[j].x)+sqr(pt[i].y-pt[j].y));
}
int main()
{
    int i,j,k;
    scanf("%d",&N);
	bitcnt[0]=0;
	rep(i,1,1<<MAXN) bitcnt[i]=bitcnt[i&(i-1)]+1;
	REP(i,N) scanf("%lf%lf",&pt[i].x,&pt[i].y);
	REP(i,1<<N) dp[i]=1e99;
	dp[0]=0;
	REP(i,1<<N)
	{
		if(bitcnt[i]&1) continue;
        REP(j,N) if(!(i&(1<<j)))
			REP(k,j) if(!(i&(1<<k)))
		{
			int now=i;
			now|=((1<<j)|(1<<k));
			double tmp=dp[i]+getdis(j,k);
			dp[now]=min(dp[now],tmp);
		}
	}
	printf("%.3lf\n",dp[(1<<N)-1]);
    return 0;
}

