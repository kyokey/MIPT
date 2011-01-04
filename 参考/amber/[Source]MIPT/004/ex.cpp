/*
	Problem: MIPT 004 Athletes
	Author: Amber
	Method: Greedy
	Date: 2006-9-27
*/
#include <iostream>
#include <algorithm>
using namespace std;

const int MAX_N = 1000;

int N;
pair <int, int> A[MAX_N];

int main()
{
	cin >> N;
	for (int i = 0; i < N; i++)
		cin >> A[i].first >> A[i].second;
	sort(A, A + N);

	int ans = 0, sum = 0;
	for (int i = 0; i < N; i++)
		if (sum <= A[i].second)
			ans++, sum += A[i].first;
	cout << ans;
}
