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
#define  MAXN     2510
#define  eps      1e-6
#define  MOD      50261
int N;
bool G[MAXN][MAXN];
char cs[MAXN];
int indegree[MAXN];
int stk[MAXN];
int ans[MAXN];
int M;
int main()
{
    int i,j,k;
    int a,b;
	scanf("%d",&N);
	scanf("%s",cs);
	clr(G);
	if(cs[0]=='<')G[0][2]=true;else G[2][0]=true;
	int bg=1;
	int len=3;
	REP(i,N-1)
	{
		scanf("%s",cs);
		REP(j,len-1)
		{
			int u=bg+j,v=bg+j+1;
			if(cs[j]=='<') G[u][v]=true;else G[v][u]=true;
		}
		if(i==N-2) break;
		scanf("%s",cs);
		int ct=0;
		for(j=bg;j<bg+len;j+=2)
		{
			int u=j,v=j+len+1;
			if(cs[ct++]=='<') G[u][v]=true;else G[v][u]=true;
		}
		bg+=len;
		len+=2;
	}
	M=N;
	N*=N;
	clr(indegree);
	REP(i,N) REP(j,N) if(G[i][j]) indegree[j]++;
	int top=0;
	REP(i,N) if(indegree[i]==0) stk[top++]=i;
	int shu=1;
	while (top>0)
	{
		int now=stk[--top];
		ans[now]=shu++;
		REP(i,N) if(G[now][i]) 
		{
			indegree[i]--;
			if(indegree[i]==0) stk[top++]=i;
		}
	}
	if(shu<=N) printf("0\n");
	else 
	{
		printf("1\n");
		len=1;
		int cnt=0;
		REP(i,M)
		{
            REP(j,len-1) printf("%d ",ans[cnt++]);
			printf("%d\n",ans[cnt++]);
			len+=2;
		}
	}
    return 0;
}

