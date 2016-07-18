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
const int BASE = (int) 1e6 + 3;
const int MAXN = (int) 7e5 + 100;
int n, C;
int f[MAXN], fi[MAXN];

int poww(int a, int n, int MOD) {
    if (n == 0) return 1;
    if (n % 2 == 1) {
        return (1ll * a * poww(a, n - 1, MOD)) % MOD;
    }

    int c = poww(a, n/2, MOD);

    return (1ll * c * c) % MOD;
}

int Cal(int k, int n) {
    int ms = f[n];
    int ts = (1ll * fi[k] * fi[n - k]) % BASE;

    return (1ll * ms * ts) % BASE;
}

int main() {
    // freopen("D2.txt", "r", stdin);

    scanf("%d %d", &n, &C);

    f[0] = 1; fi[0] = 1;
    for (int i = 1; i <= n + C - 1; i++) {
        f[i] = (1ll * f[i - 1] * i) % BASE;
        fi[i] = poww(f[i], BASE - 2, BASE);
    }
    int res = 0;
    for (int i = 1; i <= n; i++) {
        res = (res + Cal(i, i + C - 1)) % BASE;
    }

    cout << res;

}
