#include <iostream>
#include <cstdio>
#include <vector>
#include <string>

using namespace std;

typedef vector<string> strArray;

string st;

void print(strArray &answer)
{
	if (answer.size()) printf("%s", answer[0].c_str());
	for (int i = 1; i < answer.size(); i++) printf("+%s", answer[i].c_str());
	printf("\n");
};

bool findEnd(int i, int &j, int r)
{
	int s = 1; j = i;
	while (s && j <= r) 
	{
		++j;
		if (st[j] == '(') ++s;
		if (st[j] == ')') --s;
	} ;
	return !s;
};

void mult(strArray &a, strArray &b)
{
	strArray c(a); a.clear();
	for (int i = 0; i < c.size(); i ++)
		for (int j = 0; j < b.size(); j ++)
			a.push_back(c[i] + b[j]);
};

void add(strArray &a, const strArray &b)
{
	for (int i = 0; i < b.size(); i ++)
		a.push_back(b[i]);
};

bool trans(int l, int r, strArray &a)
{
	int i = l, ope = 1, j;
	strArray b, c, d;
	string s;
	a.clear();	
	if (l > r) {
		a.push_back("");
		return 1;
	};
	while (i <= r)
	{
		if (st[i] == '+')
		{
			if (ope) return 0;
			ope = 1; ++i;
		} 
		else {
			if (!ope || (st[i] < 'a' || st[i] > 'z') && st[i] != '(') return 0;
			b.clear(); b.push_back("");
			while (i <= r && (st[i] >= 'a' && st[i] <= 'z' || st[i] == '(')) 
			{
				if (st[i] == '(')
				{
					if (!findEnd(i, j, r)) return 0;
					if (!trans(i + 1, j - 1, c)) return 0;
					i = j + 1;
				}
				else {
					s = "";
					while (i <= r && st[i] >= 'a' && st[i] <= 'z') s += st[i ++];
					c.clear(); c.push_back(s);
				};
				if (c.empty()) return 0;
				mult(b, c);
			};
			if (b.size() == 1 && b[0] == "") continue;
			add(a, b); ope = 0;
		};
	};
	if (ope && !a.empty()) return 0;
	return 1;
};

strArray answer;

int main()
{
	cin >> st;
	if (trans(0, st.size() - 1, answer)) print(answer); else printf("#ERROR\n");
}
