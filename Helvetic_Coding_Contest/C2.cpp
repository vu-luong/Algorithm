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
const int MAXN = 100005;
vector<int> adj[MAXN];
int m, n;
bool fr[MAXN];
int dis[MAXN];

void dfs(int u) {
    fr[u] = false;

    for (int i = 0; i < adj[u].size(); i++) {
        int v = adj[u][i];

        if (fr[v]) {
            dis[v] = dis[u] + 1;
            dfs(v);
        }
    }
}

int main() {
    // freopen("C2.txt", "r", stdin);

    scanf("%d %d", &n, &m);

    for (int i = 1; i <= m; i++) {
        int u, v;
        scanf("%d %d", &u, &v);
        adj[u].PB(v);
        adj[v].PB(u);
    }

    memset(fr, true, sizeof(fr));
    dis[1] = 0;
    dfs(1);

    int i_max = 1;
    for (int i = 2; i <= n; i++) {
        if (dis[i] > dis[i_max])
            i_max = i;
    }

    // cout << i_max << endl;

    memset(dis, 0, sizeof(dis));
    memset(fr, true, sizeof(fr));
    dfs(i_max);

    int res = 0;
    for (int i = 1; i <= n; i++) {
        if (dis[i] > res) res = dis[i];
    }

    cout << res;

}
