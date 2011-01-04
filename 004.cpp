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
#define  MAXN     100010
#define  eps      1e-6
#define  MOD      50261
typedef long long int64;
int N,M;
typedef struct node 
{
	int a,b;
}node;
node c[MAXN];
bool cmp(const node&x,const node &y )
{
	return x.a<y.a||x.a==y.a&&x.b<y.b;
}
int64 dpm[MAXN];
int64 dp[MAXN];
int main()
{
    int i,j,k;
    scanf("%d",&N);
	REP(i,N) scanf("%d%d",&c[i+1].a,&c[i+1].b);
	sort(c+1,c+N+1,cmp);
	clr(dp);
	clr(dpm);
	rep(i,1,N+1)
	{
		if(c[i].b>=dpm[i-1]) 
		{
			dp[i]=dp[i-1]+1;
			dpm[i]=dpm[i-1]+c[i].a;
		}
		else 
		{
			dp[i]=dp[i-1];
			dpm[i]=dpm[i-1];
		}
	}
	printf("%d\n",dp[N]);
    return 0;
}

