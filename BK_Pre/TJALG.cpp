#include<bits/stdc++.h>

using namespace std;

const int MAXN = (int) 1e4 + 5;

vector<int> adj[MAXN];
int cnt;
stack<int> st;
bool fr[MAXN];
int m, n;
int num[MAXN], low[MAXN];
int res = 0;

void dfs(int u) {
    
    cnt++;
    num[u] = cnt;
    low[u] = cnt;
    st.push(u);

    for (int i = 0; i < adj[u].size(); i++) {
        int v = adj[u][i];
        if (!fr[v]) continue;
        
        if (num[v] != 0) 
            low[u] = min(low[u], num[v]);
        else {
            dfs(v);
            low[u] = min(low[u], low[v]);
        }
    }

    if (num[u] == low[u]) {
        res++;
        while (true) {
            int v = st.top();
            fr[v] = false;
            st.pop();
            if (v == u) break;
        }
    }

}

int main() {
//    freopen("TJALG.txt", "r", stdin);
    scanf("%d %d", &n, &m);

    for (int i = 1; i <= m; i++) {
        int u, v;

        scanf("%d %d", &u, &v);

        adj[u].push_back(v);
    }
    cnt = 0;
    memset(fr, true, sizeof(fr));

    for (int i = 1; i <= n; i++) {
        if (num[i] == 0) dfs(i);
    }

    cout << res;

}
