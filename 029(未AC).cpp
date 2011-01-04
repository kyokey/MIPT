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
#define   inf         10000000
#define  MAXM     310
#define  MAXN     550
#define  eps      1e-6
#define  MOD      50261
int N,M;
char tcs[MAXN][MAXN];
int cs[MAXN][MAXN];
int qu[MAXN];
bool G[MAXN][MAXN];
int dis[MAXN];
int main()
{
    int i,j,k;
    scanf("%d%d",&N,&M);
	REP(i,N) scanf("%s",tcs[i]);
	clr(G);
	REP(i,N) REP(j,M) cs[i][j]=tcs[i][j]+260;
    REP(i,N-1) REP(j,M) G[cs[i][j]][cs[i+1][j]]=G[cs[i+1][j]][cs[i][j]]=true;
	REP(i,N) REP(j,M-1) G[cs[i][j]][cs[i][j+1]]=G[cs[i][j+1]][cs[i][j]]=true;
	REP(i,MAXN) G[i][i]=false;
	memset(dis,0x7f,sizeof dis);
	int p=0,q=0;
	REP(i,N) 
	{
		int u=cs[i][0];
		if(dis[u]>inf) qu[q++]=u,dis[u]=1;
		u=cs[i][M-1];
		if(dis[u]>inf) qu[q++]=u,dis[u]=1;
	}
	REP(j,M)
	{
		int u=cs[0][j];
		if(dis[u]>inf) qu[q++]=u,dis[u]=1;
		u=cs[N-1][j];
		if(dis[u]>inf) qu[q++]=u,dis[u]=1;
	}
	while (p<q)
	{
        int now=qu[p++];
		REP(i,MAXN) if(G[now][i]&&i!='A'+260) if(dis[i]>inf) dis[i]=dis[now]+1,qu[q++]=i;
	}
	int ret=inf;
	REP(i,MAXN) if(G['A'+260][i]) ret=min(dis[i],ret);
	if(ret==inf) 
	{
		printf("-1\n");return 0;
	}
	REP(i,MAXN) if(G['A'+260][i]) ret++;
	ret--;
	printf("%d\n",ret);
    return 0;
}

