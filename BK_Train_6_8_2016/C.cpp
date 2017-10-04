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
const int MAXN = (int) 1e5 + 5;

int n, m, k;
vector< int > adj[MAXN];
int p[MAXN][25];
bool fr[MAXN];
int f[MAXN], cha[MAXN];
int dem;
bool mark[MAXN];
int root;

int lca(int x, int y) {
    for (int i = k; i >= 0; i--) {
        if (f[p[x][i]] >= f[y])
            x = p[x][i];
    }
    for (int i = k; i >= 0; i--) {
        if (f[p[y][i]] >= f[x])
            y = p[y][i];
    }

    for (int i = k; i >= 0; i--) {
        if (p[x][i] != p[y][i]) {
            x = p[x][i];
            y = p[y][i];
        }
    }

    while (x != y) {
        x = p[x][0];
        y = p[y][0];
    }

    return x;
}

int kc(int u, int v) {
    return f[u] + f[v] - 2*f[lca(u, v)];
}

void dfs(int u) {
    fr[u] = false;

    for (int i = 0; i < adj[u].size(); i++) {
        int v = adj[u][i];
        if (fr[v]) {
            f[v] = f[u] + 1;
            cha[v] = u;
            dfs(v);
        }
    }
}

int cal(int cur, int root) {

    int l = lca(root, cur);

    if (l != root) {
        return f[root] + f[cur] - 2 * f[l];
    }


    int ans = 0;
    int x = cur;
    while (true) {

        for (int i = -1; i <= k - 1; i++) {
            ans = i;
            if (f[p[x][i + 1]] < f[root]) break;
            if (mark[p[x][i + 1]]) break;
        }

        if (ans == -1) return f[cur] - f[p[x][0]];
        else {
            x = p[x][ans];
        }
    }


}

int main() {
    freopen("C.txt", "r", stdin);

    scanf("%d", &n);

    for (int i = 1; i <= n - 1; i ++) {
        int u, v;
        scanf("%d %d", &u, &v);
        adj[u].PB(v);
        adj[v].PB(u);
    }

    f[1] = 0;
    cha[1] = 0;
    memset(fr, true, sizeof(fr));
    k = trunc(log(n) / log(2));
    dfs(1);

    for (int i = 1; i <= n; i++) {
        p[i][0] = cha[i];
    }
    for (int j = 1; j <= k; j++) {
        for (int i = 1; i <= n; i++) {
            p[i][j] = p[p[i][j - 1]][j - 1];
        }
    }


    scanf("%d", &m);

    dem = 0;
    root = 0;
    memset(mark, false, sizeof(mark));
    for (int i = 1; i <= m; i++) {
        int t;
        scanf("%d", &t);
        if (t == 1) {
            int x;
            scanf("%d", &x);
            if (mark[x]) {
                mark[x] = false;
                continue;
            }

            if (dem == 0) {
                root = x;
                mark[x] = true;
                dem++;
            } else {
                int l = lca(root, x);
                int y = x;
                while (true) {
                    if (!mark[y]) {
                        mark[y] = true;
                        dem++;
                        if (y == l) break;
                        y = cha[y];
                    } else break;
                }

                if (l != root) {
                    y = cha[root];
                    while (true) {
                        if (!mark[y]) {
                            mark[y] = true;
                            dem++;
                            if (y == l) break;
                            y = cha[y];
                        } else break;
                    }
                }
            }
        } else {
            int x, y;
            scanf("%d %d", &x, &y);

            int k1;
            if (!mark[x]) k1 = cal(x, root);
            else k1 = 0;
            int k2;
            if (!mark[y]) k2 = cal(y, root);
            else k2 = 0;

            int k3 = kc(x, y);
            cout << x << " " << y << endl;
            DEBUG(k1);
            DEBUG(k2);
            DEBUG(k3);

            int res =  k3 - k1 - k2 + 1;

            cout << res << endl;

        }
    }

}
