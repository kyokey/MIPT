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
#define  MAXN     2100
#define  eps      1e-6
#define  MOD      50261
int N,M;
int dp[MAXN][MAXN];
int a[MAXN];
int main()
{
    int i,j,k;
    scanf("%d",&N);
	REP(i,N) scanf("%d",a+i);
	memset(dp,0xff,sizeof dp);
	dp[0][0]=a[0];
	if(N==1)
	{
		if(a[0]>=0) printf("1\n");
		else printf("-1\n");
		return 0;
	}
	rep(i,1,N-1)
	{
		REP(j,N)
		{
			if(dp[i-1][j]>=0&&dp[i-1][j]+a[i]>=0)
			{
				dp[i][j]=max(dp[i][j],dp[i-1][j]+a[i]);
			}
			if (dp[i-1][j]-100>=0)
			{
				dp[i][j+1]=max(dp[i][j+1],dp[i-1][j]-100);
			}
		}
	}
	int ret=inf;
	REP(i,N)  if(dp[N-2][i]>=0&&dp[N-2][i]+a[N-1]>=0) ret=min(ret,N-i);
	if(ret==inf) ret=-1;
	printf("%d\n",ret);
    return 0;
}

