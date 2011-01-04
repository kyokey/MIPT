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
#define  MAXN     20100
#define  eps      1e-6
#define  MOD      50261
int N,M;
vector<int> G[MAXN];
set<string> ms;
char cs[MAXN];
int mstack[MAXN];
int degree[MAXN];
map<string,vector<string> >mvs;
map<string,int> msi;
void preinit()
{
	int i;
    map<string,vector<string> >::iterator it;
	for (it=mvs.begin();it!=mvs.end();it++)
	{
		string key=it->first;
		vector<string> &vs=it->second;
		int ki=msi[key];
		REP(i,vs.size()) G[ki].push_back(msi[vs[i]]);
	}
}
int main()
{
    int i,j,k;
    scanf("%d",&N);
	REP(i,N)
	{
         scanf("%s",cs);int n;scanf("%d",&n);
		 string key=string(cs);
		 ms.insert(key);
		 if(mvs.find(key)!=mvs.end()) 
		 {
			 printf("NOT CORRECT\n");
			 return 0;
		 }
		 REP(j,n)
		 {
			 scanf("%s",cs);string v=string(cs);
			 mvs[key].push_back(v);
			 ms.insert(v);
		 }
	}
    set<string>::iterator it;
	int cnt=0;
	for (it=ms.begin();it!=ms.end();it++)
	{
		msi[*it]=cnt++;
	}
	preinit();
	int top=0;
	clr(degree);
	REP(i,cnt) REP(j,G[i].size())
	{
		degree[G[i][j]]++;
	}
	REP(i,cnt) if(degree[i]==0) mstack[top++]=i;
	int m=0;
	while (top>0)
	{
		m++;
		int now=mstack[--top];
        REP(i,G[now].size()) 
		{
			degree[G[now][i]]--;
			if(degree[G[now][i]]==0) mstack[top++]=G[now][i];
		}
	}
	if(m==cnt) printf("CORRECT\n");
	else printf("NOT CORRECT\n");
    return 0;
}

