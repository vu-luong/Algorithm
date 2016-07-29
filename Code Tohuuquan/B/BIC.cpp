#include <iostream>
#include <vector>
#include <stack>
#include <algorithm>
#include <cstring>
using namespace std;

const int MAXN = 10005;
const int BASE = (int)1e9;

vector <int> h[MAXN];
stack <int> S;
vector < vector <int> > SCC;
int low[MAXN], num[MAXN], lab[MAXN], d[MAXN];
bool avail[MAXN], check[MAXN];
int n, m, cnt = 0;

void Enter() {
    scanf("%d %d", &n, &m);
    for (int i = 0; i < m; i++) {
        int u, v;
        scanf("%d %d", &u, &v);
        h[u].push_back(v);
    }
}

void DFSVisit(int u) {
    S.push(u);
    num[u] = ++cnt;
    low[u] = num[u];

    for (int i = 0; i < h[u].size(); i++) {
        int v = h[u][i];
        if (avail[v])
            if (num[v])
                low[u] = min(low[u], num[v]);
            else {
                DFSVisit(v);
                low[u] = min(low[u], low[v]);
            }
    }

    if (num[u] == low[u]) {
        vector <int> T;
        int v;
        do {
            v = S.top(); S.pop();
            avail[v] = false;
            T.push_back(v);
        }
        while (v != u);
        SCC.push_back(T);
    }
}

void DFSCheck(int u) {
    avail[u] = false;
    if (u == 2) check[u] = true;
    for (int i = 0; i < h[u].size(); i++) {
        int v = h[u][i];
        if (avail[v]) DFSCheck(v);
        check[u] = check[u] || check[v];
    }
}

void Init() {
    // DFS check
    memset(avail, true, sizeof(avail));
    DFSCheck(1);

    // Tarjan - Strongly Connected Components
    memset(avail, true, sizeof(avail));
    DFSVisit(1);
}

void Topo(int u) {
    avail[u] = false;
    for (int i = 0; i < h[u].size(); i++) {
        int v = h[u][i];
        if (avail[v]) Topo(v);
    }
    lab[cnt--] = u;
}

void Solve() {
    for (int i = 0; i < SCC.size(); i++)
        if (SCC[i].size() > 1)
            for (int j = 0; j < SCC[i].size(); j++)
                if (check[SCC[i][j]]) {
                    printf("inf");
                    return ;
                }

    // Topo sort
    memset(avail, true, sizeof(avail));
    cnt = n;
    for (int i = 1; i <= n; i++)
        if (avail[i]) Topo(i);

    bool big = false;
    d[1] = 1;
    for (int i = 1; i <= n; i++) {
        int u = lab[i];
        if (check[u])
            for (int j = 0; j < h[u].size(); j++) {
                int v = h[u][j];
                if (!big)
                    big = (d[u] >= BASE || d[v] >= BASE || d[u] + d[v] >= BASE);
                d[v] = (d[v] + d[u]) % BASE;
            }
    }

    if (big) printf("%09d", d[2]);
    else printf("%d", d[2]);
}

int main() {
    Enter();
    Init();
    Solve();
}
