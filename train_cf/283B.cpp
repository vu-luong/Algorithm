#include <bits/stdc++.h>

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
int a[MAXN];
int f[MAXN][3];
long long g[MAXN][3];
int n;

void dfs(int u, int sign) {
    int next = u + sign*a[u];

    if (next <= 0 || next > n) {
        f[u][sign + 1] = 1;
        g[u][sign + 1] = a[u];
    } else {
        int x = f[next][-sign + 1];
        if (x != 0) {
            if (x == 3) {
                f[u][sign + 1] = 2;
            } 
            if (x == 1) {
                f[u][sign + 1] = 1;
                g[u][sign + 1] = g[next][-sign + 1] + a[u];
            }
            if (x == 2) {
                f[u][sign + 1] = 2;
            }
        } else {
            f[u][sign + 1] = 3;
            dfs(next, -sign);
            f[u][sign + 1] = f[next][-sign + 1];
            if (f[u][sign + 1] == 1) {
                g[u][sign + 1] = g[next][-sign + 1] + a[u];
            }
        }
    }
}
int main() {
//    freopen("283B.txt", "r", stdin);
 
    cin >> n;
    for (int i = 2; i <= n; i++) {
        cin >> a[i];
    }

    for (int i = 2; i <= n; i++) {
        if (f[i][0] == 0) {
            dfs(i, -1);
        }
    }

    dfs(n, -1);
    for (int i = 2; i <= n; i++) {
        if (f[i][0] == 1)
            cout << g[i][0] + i - 1 << endl;
        else cout << -1 << endl;
    }

}
