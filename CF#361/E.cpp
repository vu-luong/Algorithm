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

using namespace std;

#define PB push_back
#define MP make_pair
#define SZ(a) a.size()
#define DEBUG(x) cout << #x << " = " << x << endl;
#define PR(A,n)  { cout << #A << " = "; for (int i = 1, _n = (n); i <= _n; i++) \
                    cout << A[i] << ' '; cout << endl; }
#define PR0(A,n) { cout << #A << " = "; for (int i = 0, _n = (n); i < _n; i++) \
                    cout << A[i] << ' '; cout << endl; }

const int BASE = (int) 1e9 + 7;
const int MAXN = (int) 2e5 + 5;
int n, k;
int f[MAXN], fi[MAXN];

int poww(int a, int n, int MOD) {
    if (n == 0) return 1;
    if (n % 2 == 1) {
        return (1ll * a * poww(a, n - 1, MOD)) % MOD;
    }

    int c = poww(a, n/2, MOD);

    return (1ll * c * c) % MOD;
}

int C(int k, int n) {
    int ms = f[n];
    int ts = (1ll * fi[k] * fi[n - k]) % BASE;

    return (1ll * ms * ts) % BASE;
}

map< int, int> s;
int ans;

int main() {
    // freopen("E.txt", "r", stdin);

    scanf("%d %d", &n, &k);

    f[0] = 1; fi[0] = 1;
    for (int i = 1; i <= n; i++) {
        f[i] = (1ll * f[i - 1] * i) % BASE;
        fi[i] = poww(f[i], BASE - 2, BASE);
    }

    for (int i = 1; i <= n; i++) {
        int l, r;
        scanf("%d %d", &l, &r);

        s[l]++; s[r + 1]--;
    }

    int sum = 0;
    ans = 0;
    int l = s.begin()->first;

    for (auto it : s) {
        // cout << it.first << " " << it.second << endl;
        int dist = it.first - l;

        if (sum >= k) ans = (ans + (1ll * C(k, sum) * dist % BASE)) % BASE;
        sum += it.second;
        l = it.first;
    }
    cout << ans << endl;

    return 0;

}
