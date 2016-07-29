#include <iostream>
#include <algorithm>
#define FR(i, a, b) for(int i = a; i < b; i++)
#define FOR(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

const int MAXN = 18;
const int SIZE = 1 << 17;
const int oo = (int)1e9;

int a[MAXN], c[MAXN][MAXN], f[MAXN][SIZE], bit[MAXN];
int m, n;

int main() {
    scanf("%d %d", &m, &n);
    string st; getline(cin, st);
    FOR(loop, 1, m) {
        getline(cin, st); st = ' ' + st;
        FOR(i, 1, n) a[i] += (st[i] == '1');
        FOR(i, 1, n) FOR(j, 1, n)
            c[i][j] += (st[i] != st[j]);
    }

    bit[1] = 1;
    FOR(i, 2, n + 1)
        bit[i] = bit[i - 1] << 1;

    FR(j, 1, bit[n + 1]) FOR(i, 1, n)
        if (j & bit[i]) {
            int y = j - bit[i];
            if (y == 0) f[i][j] = a[i];
            else {
                f[i][j] = oo;
                int x;
                for (x = 1; x <= n; x++)
                    if (y & bit[x])
                        f[i][j] = min(f[i][j], f[x][y] + c[x][i]);

                if (i > 1) {
                    x = i - 1;
                    if (y & bit[x])
                        f[i][j] = min(f[i][j], f[x][y] + a[i]);
                }
                if (i < n) {
                    x = i + 1;
                    if (y & bit[x])
                        f[i][j] = min(f[i][j], f[x][y] + a[i]);
                }
            }
        }

    int res = oo;
    FOR(i, 1, n)
        res = min(res, f[i][bit[n + 1] - 1]);

    printf("%d", res);
}
