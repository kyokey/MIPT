#include <iostream>
#include <map>
#include <vector>

using namespace std;

const int maxn = 1000;

map<string, int> names;
int defined[maxn], visit[maxn];
vector<int> ele[maxn];

bool DFS(int u)
{
	visit[u] = 1;
	for (int i = 0, v; i < ele[u].size(); i ++)
		if (v = ele[u][i], visit[v] == 1 || DFS(v)) return 1;
	visit[u] = 2;
	return 0;
};

int main()
{
	int N, k;
	for (int i = 0; i < 1000; i ++) defined[i] = 0;
	
	cin >> N; names.clear();	
	int y = 1, m = 0;
	while (N--)
	{
		string term, st;
		cin >> term >> k;
		if (!names.count(term)) names[term] = m++;
		if (defined[names[term]]) y = 0;
		defined[names[term]] = 1;
		
		while (k--) 
		{
			cin >> st;
			if (!names.count(st)) names[st] = m++;
			ele[names[term]].push_back(names[st]);
		};
	};
	
	for (int i = 0; i < m; i ++) visit[i] = 0;
	for (int i = 0; i < m; i ++) if (!visit[i] && DFS(i)) y = 0;
	if (y) cout << "CORRECT\n"; else cout << "NOT CORRECT\n";
}
