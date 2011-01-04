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
#define  MAXN     100010
#define  eps      1e-6
#define  MOD      50261
int N,M;
//注意负数，所以负号要判定
//另外这题用amber的栈模拟写法会很简洁
bool isci(char c)
{
	return c>='0'&&c<='9'||c=='('||c==')'||c=='-';
}
bool isi(char c)
{
	return c>='0'&&c<='9'||c=='-';
}
void unc(char c)
{
	ungetc(c,stdin);
}
double solve()
{
	char c;
	while (c=getchar()) 
	{
		if(isci(c)) 
			break;
	}
	double ret=0;
	double cnt=0;
	if(isi(c)) 
	{
		unc(c);
		scanf("%lf",&ret);
		return ret;
	}
	ret+=solve();
	ret+=solve();
    while (c=getchar()) 
	{
		if(isci(c)) 
			break;
	}
	return ret/2;
}
int main()
{
    int i,j,k;
    double ret=solve();
	printf("%.2lf\n",ret);
    return 0;
}

