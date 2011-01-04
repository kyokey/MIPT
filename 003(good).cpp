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
//ghy的解法非常好，amber是暴力的
int a[MAXN];
char cs[MAXN][MAXN];
bool G[MAXN][MAXN];
int top=0;
void ainsert(int v,int p)
{
	int i;
	for (i=top-1;i>=p;i--)
	{
		a[i+1]=a[i];
	}
	a[p]=v;
	top++;
}
int main()
{
    int i,j,k;
    scanf("%d",&N);
	REP(i,N) scanf("%s",cs[i]);
	REP(i,N)
	{
		REP(j,i)
		{
			if(cs[i][j]=='+') G[i][j]=true;
			else  G[j][i]=true;
		}
	}
	a[top++]=0;
	rep(i,1,N)
	{
		if(G[i][a[0]]) ainsert(i,0);
		else if(G[a[top-1]][i]) a[top++]=i;
		else 
		{
			REP(j,top-1) if(G[a[j]][i]&&G[i][a[j+1]]) 
			{
				ainsert(i,j+1);
				break;
			}
		}
	}
	REP(i,N-1) printf("%d ",a[i]+1);
	printf("%d\n",a[i]+1);
    return 0;
}

