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
#define  MAXN     1000001
#define  eps      1e-6
#define  MOD      50261
int N;
int a[MAXN];
int main()
{
    int i,j,k;
    scanf("%d",&N);
	clr(a);
	a[1]=1;
	a[2]=a[3]=2;
	int now=2;
	int top=4;
	while (++now<MAXN)
	{
		int M=a[now];
		REP(i,M) 
			if(top<MAXN)a[top++]=now;
			else break;
		if(i!=M) break;
	}
	int total=0;
	REP(i,MAXN)
	{
		total+=a[i];
		if(total<N) continue;
		printf("%d\n",i);
		break;
	}
    return 0;
}

