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
#define  MAXN     210
#define  eps      1e-6
#define  MOD      50261
int N,M;
int sg[MAXN];
bool visited[MAXN];
int getsg(int n)
{
	clr(visited);
	int i;
	REP(i,n)
	{
		int l=i;
		int r=n-1-i;
		visited[sg[l]^sg[r]]=true;
		if(i<n-1)
		{
			l=i;
			r=n-2-i;
			visited[sg[l]^sg[r]]=true;
		}
	}
	REP(i,MAXN) if(!visited[i])  return i;
}
int main()
{
    int i,j,k;
    scanf("%d",&N);
	int ret=0;
	sg[0]=0;
    rep(i,1,201) sg[i]=getsg(i);
	REP(i,N)  
	{
		int u;scanf("%d",&u);
		ret^=sg[u];
	}
	if(!ret) printf("Second wins.\n");
	else printf("First wins.\n");
    return 0;
}

