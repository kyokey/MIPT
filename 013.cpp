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
#define  MAXN     510
#define  eps      1e-6
#define  MOD      50261
int N,M;
bool G[MAXN][MAXN];
int a[MAXN];
int b[MAXN];
int c[MAXN];
int ym[MAXN];
bool visited[MAXN];
bool dfs(int u)
{
	int i;
	REP(i,N) if(G[u][i])
	{
		if(visited[i]) continue;
		visited[i]=true;
		if(ym[i]==-1||dfs(ym[i]))
		{
			ym[i]=u;
			return true;
		}
	}
	return false;
}
int main()
{
    int i,j,k;
    scanf("%d",&N);
	REP(i,N) 
	{
		scanf("%d%d%d",a+i,b+i,c+i);
		int t[3];
		t[0]=a[i],t[1]=b[i],t[2]=c[i];
		sort(t,t+3);
		a[i]=t[0],b[i]=t[1],c[i]=t[2];
	}
	REP(i,N) REP(j,N) if(i==j) G[i][j]=0;else G[i][j]=(a[i]>a[j]&&b[i]>b[j]&&c[i]>c[j]);
	int ret=N;
	memset(ym,0xff,sizeof ym);
	REP(i,N)
	{
		clr(visited);
		if(dfs(i)) ret--;
	}
	printf("%d\n",ret);
    return 0;
}

