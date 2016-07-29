#include <iostream>
#include <queue>
#include <algorithm>
#include <vector>
#include <cstring>
#define FOR(i, a, b) for(int i = a; i<= b; i++)
#define FR(i, a, b) for(int i = a; i < b; i++)
using namespace std;

const int MAXR = 105, MAXC = 105;
const int MAXN = MAXR + MAXC + 2;
const int MAXM = MAXR * MAXC;
const int oo = MAXM * 100;

int a[MAXN][MAXN], f[MAXN][MAXN];
int d[MAXN], t[MAXN];
int n, r, c, m;

bool FindPath() {
    memset(t, 0, sizeof(t));
    queue <int> Q;
    d[1] = oo;
    Q.push(1);

    while (Q.size()) {
        int u = Q.front(); Q.pop();
        FOR(v, 1, n)
            if (t[v] == 0) {
                if (a[u][v] > f[u][v]) {
                    t[v] = u;
                    d[v] = min(d[u], a[u][v] - f[u][v]);
                }
                if (f[v][u] > 0) {
                    t[v] = -u;
                    d[v] = min(d[u], f[v][u]);
                }
                if (t[v] != 0) {
                    if (v == n) return true;
                    Q.push(v);
                }
            }
    }

    return false;
}

void IncFlow() {
    int v = n;
    while (v != 1) {
        int u = t[v];
        if (u > 0) f[u][v] += d[n];
        else {
            u = -u;
            f[v][u] -= d[n];
        }
        v = u;
    }
}

int main() {
    scanf("%d %d %d", &r, &c, &m);
    n = r + c + 2;
    FOR(i, 1, r) scanf("%d", &a[1][i + 1]);
    FOR(i, 1, c) scanf("%d", &a[r + i + 1][n]);
    FOR(i, 1, m) {
        int u, v;
        scanf("%d %d", &u, &v);
        a[u + 1][r + v + 1] = oo;
    }

    while (FindPath()) IncFlow();

    int res = 0;
    FOR(i, 1, n)
        if (a[1][i] > 0) res += f[1][i];
    printf("%d\n", res);

    vector <int> row, col;
    FOR(i, 2, r + 1)
        if (t[i] == 0) row.push_back(i - 1);
    FOR(i, r + 2, r + c + 1)
        if (t[i] > 0) col.push_back(i - (r + 1));

    printf("%d %d\n", row.size(), col.size());
    FR(i, 0, row.size()) printf("%d\n", row[i]);
    FR(i, 0, col.size()) printf("%d\n", col[i]);
}
