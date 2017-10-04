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

const int MAXN = (int) 2e3 + 5;
const int MOD = (int) 1e9 + 7;
int a[MAXN];
int n;
bool fr[MAXN];
int N, K;
int f[MAXN][MAXN];

int dp(int N, int K) {
    if (f[N][K] != -1) return f[N][K];

    if (K == 0) {
        if (N == 0) return 1;
        return f[N][K] = (1ll * dp(N - 1, 0) * N) % MOD;
    }
    if (K == 1) {
        if (N == 0) return 0;
        return f[N][K] = (1ll * N * dp(N, 0)) % MOD;
    }

    return f[N][K] = (1ll*N*dp(N, K - 1) + 1ll*(K - 1)*dp(N + 1, K - 2)) % MOD;

}

int main() {
    // freopen("E.txt", "r", stdin);

    scanf("%d", &n);

    memset(fr, true, sizeof(fr));

    for (int i = 1; i <= n; i++) {
        scanf("%d", &a[i]);

        if (a[i] != -1) fr[a[i]] = false;
    }

    for (int i = 1; i <= n; i++) {
        if (fr[i]) {
            if (a[i] == -1) K++;
            else N++;
        }
    }

    memset(f, -1, sizeof(f));

    cout << dp(N, K);

}
