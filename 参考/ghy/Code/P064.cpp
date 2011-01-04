#include <cstdio>
#include <vector>
#include <algorithm>
#include <iostream>

using namespace std;

vector<int> a;

int main()
{
	int n, k;
	scanf("%d", &n);
	for (int i = 0; i < n; i ++) scanf("%d", &k), a.push_back(k);
	sort(a.begin(), a.end());
	
	long long s = a[0]; s *= a[1]; s *= a[n - 1];
	long long t = a[n - 3]; t *= a[n - 2]; t *= a[n - 1];
	if (s > t)
		printf("%d %d %d\n", a[0], a[1], a[n - 1]);
	else 
		printf("%d %d %d\n", a[n - 3], a[n - 2], a[n - 1]);
}
