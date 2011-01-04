/*
	Problem: MIPT 001 Max of Integers
	Author: Amber
	Method: Trivial
	Date: 2006-9-27
*/
#include <iostream>
#include <vector>
#include <iterator>
using namespace std;

vector <int> a;
int main()
{
	copy(istream_iterator <int>(cin), istream_iterator <int>(), back_inserter(a));
	cout << *max_element(a.begin(), a.end());
}
