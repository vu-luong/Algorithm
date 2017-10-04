#include <bits/stdc++.h>

using namespace std;

const int MAXN = (int) 1e4 + 5;

int res_cau = 0;
int res_khop = 0;

vector<int> adj[MAXN];
int n, m;
int num[MAXN], low[MAXN], dcon[MAXN], pr[MAXN];
bool khop[MAXN];
int cnt = 0;


void dfs_khop(int u) {
    cnt++;
    num[u] = cnt;
    low[u] = n + 1;
    dcon[u] = 0;

    for (int i = 0; i < adj[u].size(); i++) {
        int v = adj[u][i];

        if (num[v] != 0) low[u] = min(low[u], num[v]);
        else {
            dcon[u]++;
            dfs_khop(v);
            if (low[v] >= num[u]) khop[u] = true;
            low[u] = min(low[u], low[v]);
        }
    }
}

void dfs_cau(int u) {
    cnt++;
    num[u] = cnt;
    low[u] = n + 1;

    for (int i = 0; i < adj[u].size(); i++) {
        int v = adj[u][i];

        if (num[v] != 0) {
            if (v != pr[u]) 
                low[u] = min(low[u], num[v]);
        } else {
            pr[v] = u;
            dfs_cau(v);
            if (low[v] > num[u]) res_cau++;
            low[u] = min(low[u], low[v]);
        }
    }
}

int main() {
//    freopen("GRAPH_.txt", "r", stdin);

    scanf("%d %d", &n, &m);

    for (int i = 1; i <= m; i++) {
        int u, v;
        scanf("%d %d", &u, &v);
        adj[u].push_back(v);
        adj[v].push_back(u);
    }

    memset(khop, false, sizeof(khop));

    for (int i = 1; i <= n; i++) {
        if (num[i] == 0) {
            dfs_khop(i);
            if (dcon[i] < 2) khop[i] = false;
        }
    }

    for (int i = 1; i <= n; i++) {
        if (khop[i]) res_khop ++;
    }

    memset(num, 0, sizeof(num));
    memset(low, 0, sizeof(low));
    cnt = 0;

    for (int i = 1; i <= n; i++) {
        if (num[i] == 0) dfs_cau(i);
    }

    printf("%d %d", res_khop, res_cau);


}
