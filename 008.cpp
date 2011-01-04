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
#define  MAXN     5000
#define  eps      1e-6
#define  MOD      50261
//其实用个左括号的计数器就够了，没必要真用栈
char cs[MAXN];
int main()
{
    int i,j,k;
    char c;
	int top=0;
	bool f=false;
	while (scanf("%c",&c)>0)
	{
		if(f) continue;
		if(c=='(') cs[top++]=c;
		else if(c==')')
		{
            if(top<1||cs[top-1]!='(') 
			{
                printf("NO\n");
				f=true;
			}
			else top--;
		}
		else continue;
	}
	if(!f) 
	if(top==0)  printf("YES\n");
	else printf("NO\n");
    return 0;
}

