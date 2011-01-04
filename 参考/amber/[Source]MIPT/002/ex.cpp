/*
	Problem: MIPT 002 Set intersection
	Author: Amber
	Method: Trivial
	Date: 2006-9-27
*/
#include <set>
#include <vector>
#include <iostream>
#include <iterator>
#include <algorithm>
using namespace std;

set <int> a, b;
vector <int> c;
int main()
{
	for (int x; cin >> x, x != -1; a.insert(x));
	for (int x; cin >> x, x != -1; b.insert(x));
	set_intersection(a.begin(), a.end(), b.begin(), b.end(), back_inserter(c));
	copy(c.begin(), c.end(), ostream_iterator <int>(cout, " "));
	if (c.size() == 0) cout << "empty";
}
