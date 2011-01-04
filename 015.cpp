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
int N,M;
typedef struct node 
{
	int a,b;
}node;
node c[MAXN];
bool cmp(const node&x,const node &y )
{
	return x.a<y.a||x.a==y.a&&x.b<y.b;
}

int main()
{
    int i,j,k;
    scanf("%d",&N);
	REP(k,N) scanf("%d%d",&c[k].a,&c[k].b);
	sort(c,c+N,cmp);
	int ret=0;
    REP(i,101) REP(j,i)
	{
        int pre=0;
		REP(k,N) if(c[k].b>j&&c[k].b<i&&c[k].a>pre)
		{		
			ret=max(ret,(i-j)*(c[k].a-pre));
			pre=c[k].a;
		}
		ret=max(ret,(i-j)*(100-pre));
	}
	printf("%d\n",ret);
    return 0;
}

