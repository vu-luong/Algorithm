#include <iostream>
#include <algorithm>
#include <cmath>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
#define sqr(x) ((x) * (x))
using namespace std;

const int MAXN = 105;
const float oo = 1e9;

int x[MAXN], y[MAXN], s[MAXN], a[MAXN][MAXN];
float t[MAXN], d[MAXN][MAXN];
bool avail[MAXN];
int n;

int main() {
    scanf("%d", &n);
    FOR(i, 1, n) {
        scanf("%d %d %d", &x[i], &y[i], &s[i]);
        FOR(j, 1, n - 1) scanf("%d", &a[i][j]);
        t[i] = oo;
        avail[i] = true;
    }

    FOR(i, 1, n) FOR(j, 1, n)
        d[i][j] = sqrt(sqr(x[i] - x[j]) + sqr(y[i] - y[j]));

    t[1] = 0;
    FOR(loop, 1, n) {
        int u = 0;
        FOR(i, 1, n)
            if (avail[i]) {
                if (u == 0) u = i;
                if (t[i] < t[u]) u = i;
            }
        avail[u] = false;

        FOR(i, 1, n - 1) {
            int v = a[u][i];
            if (avail[v]) {
                t[v] = min(t[v], t[u] + d[u][v]);
                if (--s[u] == 0) break;
            }
        }
    }

    FOR(i, 1, n)
        printf("%0.10f\n", t[i]);
}
