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

int main()
{
    int i,j,k;
    N=4;
	int a=0;
	bool f=false;
	REP(i,N)
	{
		int b;scanf("%d",&b);
		f|=(b>1);
		a^=b;
	}
	if(a==0&&f||a!=0&&!f) printf("Second wins.\n");
	else printf("First wins.\n");
    return 0;
}

