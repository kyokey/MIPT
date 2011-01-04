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
char cs[MAXN];
bool isok(char a,char b)
{
	if(a=='('&&b==')') return true;
	if(a=='{'&&b=='}') return true;
	if(a=='['&&b==']') return true;
	if(a=='<'&&b=='>') return true;
	return false;
}
int main()
{
    int i,j,k;
    char c;
	int top=0;
	while (scanf("%c",&c)>0)
	{
		if(c=='('||c=='{'||c=='['||c=='<') cs[top++]=c;
		else if(c==')'||c=='}'||c==']'||c=='>')
		{
            if(top>0&&isok(cs[top-1],c)) top--;
			else 
			{
				printf("NO\n");
				return 0;
			}
		}
		else continue;
	}
	if(top==0)  printf("YES\n");
	else printf("NO\n");
    return 0;
}

