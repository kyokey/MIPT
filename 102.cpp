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
#define  MAXN     (1<<18)
#define  eps      1e-6
#define  MOD      50261
int N,M;
int sg[MAXN];
int main()
{
    int i,j,k;
    int cnt=1;
	sg[0]=0;
	int idx=1;
	for (i=1;;i++)
	{
		int tidx=idx;
		if(tidx>100000) break;
		REP(j,1<<(i-1))
		{
			sg[tidx]=sg[idx-(1<<(i-1))+j];
			tidx+=2;
		}
		tidx=idx+1;
		REP(j,1<<(i-1)) 
		{
			sg[tidx]=cnt++;
			tidx+=2;
		}
		idx+=(1<<i);
	}
	scanf("%d",&N);
	int ret=0;
	REP(i,N)
	{
		int t;scanf("%d",&t);
		ret^=sg[t];
	}
	if(ret>0) printf("First wins.\n");
	else printf("Second wins.\n");
    return 0;
}

