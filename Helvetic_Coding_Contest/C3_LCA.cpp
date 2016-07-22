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
