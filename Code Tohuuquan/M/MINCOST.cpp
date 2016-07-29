#include <iostream>
#include <queue>
#include <cstring>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

typedef long long int64;

const int MAXN = 105;
const int oo = (int)2e9;

int c[MAXN][MAXN], w[MAXN][MAXN], f[MAXN][MAXN];
int trace[MAXN], d[MAXN];
bool avail[MAXN];
int n, m, k, s, t;

void Enter() {
    scanf("%d %d %d %d %d", &n, &m, &k, &s, &t);
    FOR(u, 0, n) FOR(v, 0, n)
        if (u != v) c[u][v] = oo;
    FOR(i, 1, m) {
        int u, v; scanf("%d %d", &u, &v);
        scanf("%d %d", &c[u][v], &w[u][v]);
        c[v][u] = c[u][v];
        w[v][u] = w[u][v];
    }
    w[0][s] = w[s][0] = k;
    c[0][s] = c[s][0] = 0;
}

void FindPath() {
    FOR(v, 0, n) d[v] = oo, trace[v] = 0;
    memset(avail, true, sizeof(avail));
    queue <int> Q;
    Q.push(0); d[0] = 0; avail[0] = false;

    while (Q.size()) {
        int u = Q.front(); Q.pop(); avail[u] = true;
        FOR(v, 0, n)
            if (w[u][v] > f[u][v] && d[v] > d[u] + c[u][v]) {
                d[v] = d[u] + c[u][v];
                trace[v] = u;
                if (avail[v]) Q.push(v), avail[v] = false;
            }
    }
}

void IncFlow() {
    if (d[t] == oo) return;
    int v = t, delta = oo;
    while (v > 0) {
        int u = trace[v];
        if (c[u][v] >= 0)
            delta = min(delta, w[u][v] - f[u][v]);
        else
            delta = min(delta, f[v][u]);
        v = u;
    }

    v = t;
    while (v > 0) {
        int u = trace[v];
        if (c[u][v] >= 0) f[u][v] += delta, c[v][u] = -c[u][v];
        else {
            f[v][u] -= delta;
            if (f[v][u] == 0) c[u][v] = c[v][u];
        }
        v = u;
    }
}

void Solve() {
    do FindPath(), IncFlow();
    while (d[t] != oo && f[0][s] != k);
}

void Print() {
    if (f[0][s] != k) printf("-1");
    else {
        int64 res = 0;
        FOR(u, 1, n) FOR(v, 1, n)
            if (f[u][v] > 0) res += (int64)c[u][v] * f[u][v];
        printf("%lld\n", res);
        FOR(u, 1, n) FOR(v, 1, n)
            if (f[u][v] > 0)
                printf("%d %d %d\n", u, v, f[u][v]);
        printf("0 0 0");
    }
}

int main() {
    Enter();
    Solve();
    Print();
}
