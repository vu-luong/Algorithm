#include <iostream>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

const int MAXN = 2005;
const int oo = (int)2e9;

int a[MAXN];
int f[MAXN][MAXN], w[MAXN][MAXN], k[MAXN][MAXN];
int n;

int main() {
    scanf("%d", &n);
    FOR(i, 1, n) scanf("%d", a + i);

    FOR(i, 1, n) {
        w[i][i] = a[i];
        FOR(j, i + 1, n)
            w[i][j] = w[i][j - 1] + a[j];
    }
    FOR(i, 1, n) f[i][i] = 0, k[i][i] = i;

    FOR(l, 2, n) FOR(i, 1, n - l + 1) {
        int j = i + l - 1;
        f[i][j] = oo;
        FOR(t, k[i][j - 1], k[i + 1][j]) {
            int v = w[i][j] + f[i][t - 1] + f[t][j];
            if (v < f[i][j]) f[i][j] = v, k[i][j] = t;
        }
    }

    printf("%d", f[1][n]);
}
