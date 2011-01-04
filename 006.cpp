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
#define  MAXN     10000
#define  eps      1e-6
#define  MOD      50261
int N,M;
bool ans[MAXN];
int main()
{
    int i,j,k;
    clr(ans);
	REP(i,100) REP(j,100) REP(k,100) if(i*i+j*j+k*k<MAXN) ans[i*i+j*j+k*k]=true;
	scanf("%d",&N);
	int ret=0;
	REP(i,N+1) if(!ans[i]) ret++;
	printf("%d\n",ret);
    return 0;
}

