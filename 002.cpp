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
#define  MAXN     1000
#define  eps      1e-6
#define  MOD      50261
int N,M;
set<int> sa;
set<int> sb;
set<int>::iterator it;
int main()
{
    int i,j,k;
    int a,b;
	while(scanf("%d",&a)&&a!=-1) sa.insert(a);
	while(scanf("%d",&a)&&a!=-1) sb.insert(a);
	vector<int> ans;
	for (it=sa.begin();it!=sa.end();it++)
	{
		if(sb.find(*it)!=sb.end())
			ans.push_back(*it);
	}
	if(ans.size()==0) printf("empty\n");
	else 
	{
		REP(i,ans.size()-1) printf("%d ",ans[i]);
		printf("%d\n",ans[i]);
	}
    return 0;
}

