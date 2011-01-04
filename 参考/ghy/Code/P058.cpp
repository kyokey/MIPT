#include <set>
#include <cstdio>
#include <iostream>

using namespace std;

multiset<int> s;

int main()
{
	int n, k;
	long long cost;
	scanf("%d", &n);
	s.clear(); cost = 0;
	
	while (n--) 
	{
		scanf("%d", &k);
		if (k) s.insert(k);
	};
	
	while (s.size() > 1)
	{
		int p = *s.begin(); s.erase(s.begin());
		int q = *s.begin(); s.erase(s.begin());
		cost += p + q;
		s.insert(p + q);
	};
	cout << cost << endl;
};
