#include <iostream>
#include <queue>
#include <algorithm>
#include <cstring>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

const int MAXR = 105, MAXC = 105;
const int MAXN = MAXR + MAXC + 2;
const int oo = (int)1e9;

int a[MAXN][MAXN], f[MAXN][MAXN];
int d[MAXN], t[MAXN];
int r, c, n, res = 0, sum;

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
    sum += d[n];
}

int main() {
    scanf("%d %d", &r, &c);
    n = r + c + 2;
    FOR(i, 1, r) a[1][i + 1] = 2;
    FOR(i, 1, r) FOR(j, 1, c) {
        char ch;
        do scanf("%c", &ch); while (ch != '0' && ch != '1');
        if (ch == '1') a[i + 1][r + j + 1] = 1;
    }

    do {
        ++res; sum = 0;
        FOR(j, 1, c) a[r + j + 1][n] = res;
        memset(f, 0, sizeof(f));
        while (FindPath()) IncFlow();
    }
    while (sum != r * 2);

    printf("%d", res);
}
