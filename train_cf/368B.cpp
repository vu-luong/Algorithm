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

const int MAXN = (int) 1e5 + 10;
int n, m;
int a[MAXN], f[MAXN], d[MAXN];

int main() {
    freopen("368B.txt", "r", stdin);
    scanf("%d %d", &n, &m);

    for (int i = 1; i <= n; i++) {
        scanf("%d", &a[i]);
    }

    f[n + 1] = 0;
    for (int i = n; i >= 1; i--) {
        if (d[a[i]] == 0) {
            f[i] = f[i + 1] + 1;
        } else {
            f[i] = f[i + 1];
        }
        d[a[i]]++;
    }

    for (int i = 1; i <= m; i++) {
        int u;
        scanf("%d", &u);
        cout << f[u] << endl;
    }
}
