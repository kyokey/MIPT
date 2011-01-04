#include <iostream>
#include <set>
#include <deque>

using namespace std;


typedef unsigned char	byte;
typedef unsigned short	int16u;
typedef int		int32s;
typedef unsigned	int32u;

const int16u	BM_TYPE = 0x4d42;  // 0x42 = "B" 0x4d = "M"
const int32u	BM_RGB	= 0;

#pragma pack (push,2)
struct file_header {
	int16u		type;
	int32u		size;
	int16u		reserved1;
	int16u		reserved2;
	int32u		offbits;
} bf;

struct info_header {
	int32u		size;
	int32s		width;
	int32s		height;
	int16u		planes;
	int16u		bit_count;
	int32u		compression;
	int32u		size_image;
	int32s		x_pels_per_meter;
	int32s		y_pels_per_meter;
	int32u		clr_used;
	int32u		clr_important;
} bi;
#pragma pack (pop)

const int maxn = 1024;

int col[maxn * maxn];
bool used[maxn * maxn];
deque<int> queue;

void solve()
{
	queue.clear(); 
	int cnt = 0, n = bi.height, m = bi.width;
	for (int i = 0; i < n; i ++)
		for (int j = 0; j < m; j ++)
		if (!used[i * m + j])
		{
			queue.push_back(i * m + j);
			used[i * m + j] = 1;
			++cnt;
			while (!queue.empty())
			{
				int s = queue.front(), x = s / m, y = s % m;
				queue.pop_front();
				if (y < m - 1 && !used[s + 1] && col[s] == col[s + 1]) 
					used[s + 1] = 1, queue.push_back(s + 1);
				if (y > 0 && !used[s - 1] && col[s] == col[s - 1]) 
					used[s - 1] = 1, queue.push_back(s - 1);
				if (x < n - 1 && !used[s + m] && col[s] == col[s + m]) 
					used[s + m] = 1, queue.push_back(s + m);
				if (x > 0 && !used[s - m] && col[s] == col[s - m]) 
					used[s - m] = 1, queue.push_back(s - m);
			};
		};
	cout << cnt << endl;
};

int main()
{
	freopen("a.bmp", "r", stdin);
	freopen("output.txt", "w", stdout);

    cin.read((char *)&bf, sizeof(bf));
    cin.read((char *)&bi, sizeof(bi));

//    cout << "Width=" << bi.width << " Height=" << bi.height << endl;

    if (bf.type != BM_TYPE)
        return 1; //throw unsupported(unsupported::file_type, bf.type);
    if (bi.compression != BM_RGB)
	return 2; //throw unsupported(unsupported::compression, bi.compression);
    
    long color = 0;;
    byte brg[3];
    set<long> colors;
    
    long w, h;
    for(h = 0; h < bi.height; h++)
    {
        for(w = 0; w < bi.width ; w++)
        {
            cin.read((char *)brg, 3);
            col[h * bi.width + w] = brg[0] + 256*brg[1] + 256*256*brg[2];
        }
        if(bi.width % 4) cin.read((char*)brg, bi.width%4);
    }
    
    solve();
//    cout << "Distinct colors: " << colors.size() << endl;
    return 0;
}
