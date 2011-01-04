#include <iostream>
#include <set>
#include <deque>

using namespace std;

const int RF[3][8] = {	{1, 3, 5, 7, 9, 11, 13, 15},
						{17, 18, 5, 6, 21, 22, 16, 15},
						{3, 4, 21, 23, 10, 9, 20, 18}};
const int RG[3][8] = {	{17, 18, 19, 20},
						{1, 3, 4, 2},
						{5, 6, 8, 7}};

struct TCube
{
	int a[24], dep;
	
	bool fit()
	{
		for (int i = 0; i < 24; i += 4)
		if (a[i] != a[i + 1] || a[i + 1] != a[i + 2] || a[i + 2] != a[i + 3]) return 0;
		return 1;
	};
	
	TCube expand(int k)
	{
		TCube t(*this);
		++t.dep;
		int p, q;
		if (k < 3)
		{
			p = t.a[RF[k][0] - 1]; q = t.a[RF[k][1] - 1];
			for (int i = 0; i < 6; i ++) t.a[RF[k][i] - 1] = t.a[RF[k][i + 2] - 1];
			t.a[RF[k][6] - 1] = p; t.a[RF[k][7] - 1] = q;
			p = t.a[RG[k][0] - 1];
			for (int i = 0; i < 3; i ++) t.a[RG[k][i] - 1] = t.a[RG[k][i + 1] - 1];
			t.a[RG[k][3] - 1] = p;
		} else
		{
			k -= 3;
			p = t.a[RF[k][6] - 1]; q = t.a[RF[k][7] - 1];
			for (int i = 5; i >= 0; i ++) t.a[RF[k][i + 2] - 1] = t.a[RF[k][i] - 1];
			t.a[RF[k][0] - 1] = p; t.a[RF[k][1] - 1] = q;
			p = t.a[RG[k][3] - 1];
			for (int i = 2; i >= 0; i ++) t.a[RG[k][i + 1] - 1] = t.a[RG[k][i] - 1];
			t.a[RG[k][0] - 1] = p;
		};
		return t;
	};
};

deque<TCube> queue;
set<TCube> state;

istream& operator>>(istream &is, TCube &item)
{
	item.dep = 0;
	for (int i = 0; i < 24; i ++) cin >> item.a[i];
};

bool operator<(const TCube &s, const TCube &t)
{
	for (int i = 0; i < 24; i ++)
	{
		if (s.a[i] < t.a[i]) return 1;
		if (s.a[i] > t.a[i]) return 0;
	};
	return 0;
};

int main()
{
}
