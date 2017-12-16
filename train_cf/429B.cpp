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
const int MAXN = 1005;
int m, n;
int a[MAXN][MAXN], f[MAXN][MAXN], f1[MAXN][MAXN], f2[MAXN][MAXN];
int g1[MAXN][MAXN], g2[MAXN][MAXN];
int h1[MAXN][MAXN], h2[MAXN][MAXN];
int k1[MAXN][MAXN], k2[MAXN][MAXN];
int main() {
//    freopen("429B.txt", "r", stdin);

    cin >> n >> m;
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            scanf("%d", &a[i][j]);
        }
    }

    memset(f, 0, sizeof(f));
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            f[i][j] = max(f[i - 1][j], f[i][j - 1]) + a[i][j];
            f1[i][j] = f[i - 1][j] + a[i][j];
            f2[i][j] = f[i][j - 1] + a[i][j];
        }
    }

    memset(f, 0, sizeof(f));
    for (int i = 1; i <= n; i++) {
        for (int j = m; j >= 1; j--) {
            f[i][j] = max(f[i - 1][j], f[i][j + 1]) + a[i][j];
            g1[i][j] = f[i][j + 1] + a[i][j];
            g2[i][j] = f[i - 1][j] + a[i][j];
        }
    }

    memset(f, 0, sizeof(f));
    for (int i = n; i >= 1; i--) {
        for (int j = m; j >= 1; j--) {
            f[i][j] = max(f[i][j + 1], f[i + 1][j]) + a[i][j];
            h1[i][j] = f[i + 1][j] + a[i][j];
            h2[i][j] = f[i][j + 1] + a[i][j];
        }
    }

    memset(f, 0, sizeof(f));
    for (int i = n; i >= 1; i--) {
        for (int j = 1; j <= m; j++) {
            f[i][j] = max(f[i][j - 1], f[i + 1][j]) + a[i][j];
            k1[i][j] = f[i][j - 1] + a[i][j];
            k2[i][j] = f[i + 1][j] + a[i][j];
        }
    }

    int res = 0;

    for (int i = 2; i <= n - 1; i++) {
        for (int j = 2; j <= m - 1; j++) {
            res = max(res, f1[i][j] + g1[i][j] 
                    + h1[i][j] + k1[i][j] - 4*a[i][j]);
            res = max(res, f2[i][j] + g2[i][j] 
                    + h2[i][j] + k2[i][j] - 4*a[i][j]);
        }
    }

    cout << res << endl;

}
