/*
	Problem: MIPT 005 Random descending a tree
	Author: Amber
	Method: Simulate
	Date: 2006-9-27
*/
#include <cstdio>
#include <cctype>
using namespace std;

int main()
{
	double answer = 0;
	double coeff = 1;
	char c;

	while ((c = getchar()) != EOF)
		if (c == '(')
			coeff /= 2;
		else if (c == ')')
			coeff *= 2;
		else if (isdigit(c) || c == '-')
		{
			ungetc(c, stdin);
			int value;
			scanf("%d", &value);
			answer += coeff * value;
		}
	printf("%.2lf\n", answer);
}
