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
#define  MAXN     110
#define  eps      1e-6
#define  MOD      50261
int N;
typedef struct node 
{
	double x;
	double y;
	double v;
}node;
node a[MAXN];
int main()
{
    int i,j,k;
    scanf("%d",&N);
	REP(i,N) scanf("%lf%lf%lf",&a[i].x,&a[i].y,&a[i].v);
	double av=1e99,ax,ay;
	for (i=-600;i<=600;i++)
	{
		for (j=-600;j<=600;j++)
		{
			double x=15.0*i/600,y=15.0*j/600,v=0;
			REP(k,N)
			{
				v+=sqrt(sqr(x-a[k].x)+sqr(y-a[k].y))*a[k].v;
				if(v>av) break;
			}
			if(v<av) av=v,ax=x,ay=y;
		}
	}
	printf("%.2lf %.2lf\n",ax,ay);
    return 0;
}

