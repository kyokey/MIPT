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
#define  MAXN     2000010
#define  eps      1e-6
#define  MOD      50261
int N,M;
typedef long long int64;
int64 pcnt[MAXN];
int main()
{
    int i,j,k;
    scanf("%d",&N);
	clr(pcnt);
	rep(i,2,N+1) pcnt[i]=i;
	rep(i,2,N+1) 
		if(pcnt[i]==i)
			for (j=i;j<=N;j+=i)
			{
				pcnt[j]=pcnt[j]*(i-1)/i;
			}
	int64 ret=0;
	REP(i,N+1) ret+=pcnt[i];
	int ans=0;
	while (ret>1)
	{
		ret=(ret+1)/2;
		ans++;
	}
	printf("%d\n",ans);
    return 0;
}

