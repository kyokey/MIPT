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
#define  MAXE     15010
#define  MAXN     1010
#define  eps      1e-6
#define  MOD      50261
int head[MAXN];
typedef struct node 
{
	int v;
	int next;
}node;
node E[MAXE];
int N,M,C;
int ym[MAXN];
bool visited[MAXN];
int top=0;
void adde(int u,int v)
{
     E[top].v=v;
	 E[top].next=head[u];
	 head[u]=top++;
}
bool dfs(int u)
{
	int i;
	for (i=head[u];i!=-1;i=E[i].next)
	{
		int v=E[i].v;
        if(!visited[v])
		{
			visited[v]=true;
			if(ym[v]==-1||dfs(ym[v]))
			{
				ym[v]=u;
                return true;
			}
		}
	}
	return false;
}
int main()
{
    int i,j,k;
    scanf("%d%d%d",&N,&M,&C);
	top=0;
	REP(i,MAXN)head[i]=-1,ym[i]=-1;
	REP(i,C)
	{
		int u,v;
		scanf("%d%d",&u,&v);
		adde(u,v);
	}
	int ret=0;
	rep(i,1,N+1)
	{
        clr(visited);
		if(dfs(i)) ret++;
	}
	printf("%d\n",ret);
	REP(i,M+1) if(ym[i]!=-1) printf("%d %d\n",ym[i],i);
    return 0;
}

