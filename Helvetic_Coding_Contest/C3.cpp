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
const int MAXN = (int) 2e5 + 5;
int n, k;
int cha[MAXN];
int p[MAXN][20];
int u;
int x1, x2;
int res;
int f[MAXN];

int getbit(int x, int k) {
    return (x >> k) & 1;
}

int lca(int x, int y) {
    int u, v;
    int ans;
    if (x == y) return x;
    if (f[x] >= f[y]) {
        u = x;
        v = y;
    } else {
        u = y;
        v = x;
    }

    int t = f[u] - f[v];

    for (int i = k; i >= 0; i--) {
        if (getbit(t, i) == 1) {
            u = p[u][i];
        }
    }

    if (u == v) return u;
    ans = p[u][k];
    int l = ans;
    int r = l;
    int nh = k;

    while (true) {
        while (l == r) {
            if (l == p[u][0]) return l;
            nh--;
            l = p[u][nh];
            r = p[v][nh];
        }
        u = l;
        v = r;
        l = p[u][k];
        r = l;
        nh = k;
    }
}

int kc(int u, int v) {
    return f[u] + f[v] - 2*f[lca(u, v)];
}

int main() {
    // freopen("C3.txt", "r", stdin);

    scanf("%d", &n);

    if (n == 2) {
        cout << "1";
        return 0;
    }

    k = trunc(log(n)/log(2));
    scanf("%d", &u);

    cha[2] = 1;
    p[2][0] = 1;
    for (int j = 1; j <= k; j++) {
        p[2][j] = p[p[2][j - 1]][j - 1];
    }

    x1 = 1; x2 = 2;
    res = 1;

    cout << res << " ";
    f[1] = 0;
    f[2] = 1;

    for (int i = 3; i <= n; i++) {
        scanf("%d", &u);
        int k1 = kc(x1, u);
        int k2 = kc(x2, u);
        int neww = max(k1, k2) + 1;

        if (neww > res) {
            res = neww;
            if (k1 > k2) {
                x2 = i;
            } else x1 = i;
        }

        cout << res << " ";

        f[i] = f[u] + 1;
        cha[i] = u;
        p[i][0] = u;
        for (int j = 1; j <= k; j++) {
            p[i][j] = p[p[i][j - 1]][j - 1];
        }
    }


}
