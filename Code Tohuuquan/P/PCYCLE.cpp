#include <iostream>
#include <vector>
#include <stack>
using namespace std;

const int MAXN = 205;
const int MAXM = MAXN * (MAXN + 1) / 2;

int c[MAXN][MAXN], deg[MAXN];
bool a[MAXN][MAXN];
int way[MAXM], e[MAXM];
int n, m, cnt = 0;

int main() {
    scanf("%d %d", &n, &m);
    int s = 0;
    for (int i = 0; i < m; i++) {
        int u, v;
        scanf("%d %d", &u, &v);
        ++deg[u]; ++deg[v];
        a[u][v] = a[v][u] = true;
        scanf("%d", &c[u][v]);
        c[v][u] = c[u][v];
        s += c[u][v];
    }
    if (s < 0) { printf("-1"); return 0; }

    for (int i = 1; i <= n; i++)
        if (deg[i] % 2 != 0) { printf("-1"); return 0; }

    stack <int> S;
    S.push(1);
    while (S.size()) {
        int u = S.top();
        bool flag = true;
        for (int v = 1; v <= n && flag; v++)
            if (a[u][v]) {
                S.push(v);
                a[u][v] = a[v][u] = false;
                flag = false;
            }
        if (flag) way[cnt++] = u, S.pop();
    }
    if (--cnt != m) { printf("-1"); return 0; }

    int start = 0;
    do {
        int tmp = start;
        e[start] = 0;
        for (int i = 0; i < cnt; i++) {
            int u = (start + i) % cnt;
            int v = (start + i + 1) % cnt;
            e[v] = e[u] + c[way[u]][way[v]];
            if (e[v] < e[tmp]) tmp = v;
        }
        start = tmp;
    }
    while (e[start] < 0);

    for (int i = 0; i <= cnt; i++)
        printf("%d ", way[(start + i) % cnt]);
}
