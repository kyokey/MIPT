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
#define  MAXN     510
#define  eps      1e-6
#define  MOD      50261
int N,M;
bool  visited[MAXN];
bool isok(int n)
{
	clr(visited);
	int liu=N-1;
	int t=n%N-1;
	int now=t<0?t+N:t;
	if(now<N/2) return false;
	visited[now]=true;
	while (true)
	{
		int l=n%liu;
		if(l==0) l=liu;
		int cnt=0;
		while (true)
		{	
			if(!visited[now])
			{
				cnt++;
				if(cnt>=l)
				{
				  visited[now]=true;
				  break;
				}
			}
			now=(now+1)%N;
		}		
		if(now<N/2) 
		{
            if(liu>N/2)return false;
		    else return true;
		}
		liu--;
	}
	return true;
}
int main()
{
    int i,j,k;
    scanf("%d",&N);
	N<<=1;
	rep(i,N/2+1,10000000)
	{
         if(isok(i))break;
	}
	printf("%d\n",i);
    return 0;
}

