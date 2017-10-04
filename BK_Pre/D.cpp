#include <map>
#include <set>
#include <cmath>
#include <cstdio>
#include <vector>
#include <string>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <algorithm>

#define PB push_back
#define MP make_pair
#define SZ(a) a.size()
#define DEBUG(x) cout << #x << " = " << x << endl;

#define PR(A,n)  { cout << #A << " = "; for (int i = 1, _n = (n); i <= _n; i++) \
                    cout << A[i] << ' '; cout << endl; }
#define PR0(A,n) { cout << #A << " = "; for (int i = 0, _n = (n); i < _n; i++) \
                    cout << A[i] << ' '; cout << endl; }

using namespace std;
const int MAXN = (int) 1e4 +5;
const int inf = (int) 1e9 + 7;
vector < pair<int, int> > a[MAXN];
int res;
int fr[MAXN];
int n, k, m;
int f[MAXN][2005];

int dem;
void dfs(int u) {
    fr[u] = false;

    for (int i = 0; i < a[u].size(); i++) {
        int v = a[u][i].first;

        if (fr[v]) {
            dfs(v);

            for (int j = 1; j <= k - 1; j++) {
                res = min(res, f[u][j] + f[v][k - j - 1] + a[u][i].second);
            }

            for (int j = 1; j <= k; j++) {
                f[u][j] = min(f[u][j], f[v][j - 1] + a[u][i].second);
            }
        }
    }

    res = min(res, f[u][k]);
}

int main() {
    // freopen("D.txt", "r", stdin);

    scanf("%d %d", &n, &k);

    scanf("%d", &m);

    for (int i = 1; i <= m; i++) {
        int u, v, x;
        scanf("%d %d %d", &u, &v, &x);

        a[u].PB(MP(v, x));
        a[v].PB(MP(u, x));
    }

    res = inf;
    dem = 0;
    memset(fr, true, sizeof(fr));
    for (int i = 0; i <= n; i++) {
        for (int j = 1; j <= k; j++) {
            f[i][j] = inf;
        }
    }
    dfs(1);

    cout << res;

}
