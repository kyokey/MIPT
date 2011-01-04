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
int n1,n2;
char cs1[MAXN];
char cs2[MAXN];
int dp[MAXN][MAXN];
string s[MAXN][MAXN];
int solve(int n1,int n2)
{
	int &ret=dp[n1][n2];
	if(ret!=inf) return ret;
	string &rs=s[n1][n2];
	if(n1==0&&n2==0)
	{
         return 0;
	}
	else if(n1==0||n2==0) 
	{
		if(n1==0)
		{
             int j;
			 for (j=n2;j>=0;j--)
			 {
				 if(cs2[j]!='*') return inf-500;
			 }
		}
		else if(n2==0)
		{
              int j;
			 for (j=n1;j>=0;j--)
			 {
				 if(cs1[j]!='*') return inf-500;
			 }
		}
		rs="";
		return 0;
	}
	int i;
	if(cs1[n1]=='*'&&cs2[n2]=='*')
	{
        int tret=solve(n1-1,n2-1);
		if(tret<ret) 
		{
			ret=tret;
			rs=s[n1-1][n2-1];
		}
        tret=solve(n1-1,n2);
		if(tret<ret) 
		{
			ret=tret;
			rs=s[n1-1][n2];
		}
		tret=solve(n1,n2-1);
		if(tret<ret) 
		{
			ret=tret;
			rs=s[n1][n2-1];
		}
		return ret;
	}
	else if (cs1[n1]=='*')
	{
        int tret=solve(n1-1,n2);
		if(tret<ret)
		{
			ret=tret;
			rs=s[n1-1][n2];
		}
		tret=solve(n1,n2-1)+1;
		if(tret<ret)
		{
			ret=tret;
			rs=s[n1][n2-1]+cs2[n2];
		}
		return ret;
	}
	else if(cs2[n2]=='*')
	{
        int tret=solve(n1,n2-1);
		if(tret<ret)
		{
			ret=tret;
			rs=s[n1][n2-1];
		}
		tret=solve(n1-1,n2)+1;
		if(tret<ret)
		{
			ret=tret;
			rs=s[n1-1][n2]+cs1[n1];
		}
		return ret;
	}
	else if(cs1[n1]=='?'||cs2[n2]=='?'||cs1[n1]==cs2[n2])
	{
		char t=cs1[n1];if(t=='?') t=cs2[n2];
		int tret=solve(n1-1,n2-1)+1;
		if(tret<ret)
		{
			ret=tret;
			rs=s[n1-1][n2-1]+t;
		}
		return ret;
	}
	return inf;
}
int main()
{
    int i,j,k;
    scanf("%s",cs1);
	scanf("%s",cs2);
	n1=strlen(cs1);
	n2=strlen(cs2);
	for(i=n1-1;i>=0;i--) cs1[i+1]=cs1[i];
	for(i=n2-1;i>=0;i--) cs2[i+1]=cs2[i];
	REP(i,MAXN) REP(j,MAXN) dp[i][j]=inf;
	s[0][0]="";
	solve(n1,n2);
	if(dp[n1][n2]>10000) 
	{
		printf("#\n");return 0;
	}
	string ret=s[n1][n2];
	REP(i,ret.length()) if(ret[i]=='?') ret[i]='A';
	printf("%s\n",ret.c_str());
    return 0;
}

