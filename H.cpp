// General matching on graph
// Notes:
// - Index from 1
// - Directed (--> if undirected graph, must add edge in both direction)
#include <bits/stdc++.h>
const int MAXN = 1005;
const int MAXM = 50005;

#define DEBUG(x) cout << #x << " = " << x << endl;

using namespace std;

int last[MAXN];
bool fr[MAXN];
set<int> li[300];


struct EdmondsLawler {
    int n, E, start, finish, newRoot, qsize, adj[MAXM], next[MAXM], last[MAXN], mat[MAXN],
    que[MAXN], dad[MAXN], root[MAXN];
    bool inque[MAXN], inpath[MAXN], inblossom[MAXN];
    void init(int _n) {
        n = _n; E = 0;
        for(int x=1; x<=n; ++x) { last[x] = -1; mat[x] = 0; }
    }
    void add(int u, int v) {
        adj[E] = v; next[E] = last[u]; last[u] = E++;
    }
    int lca(int u, int v) {
        for(int x=1; x<=n; ++x) inpath[x] = false;
        while (true) {
            u = root[u];
            inpath[u] = true;
            if (u == start) break;
            u = dad[mat[u]];
        }
        while (true) {
            v = root[v];
            if (inpath[v]) break;
            v = dad[mat[v]];
        }
        return v; }
    void trace(int u) {
        while (root[u] != newRoot) {
            int v = mat[u];

            inblossom[root[u]] = true;
            inblossom[root[v]] = true;
            u = dad[v];
            if (root[u] != newRoot) dad[u] = v;
        }
    }
    void blossom(int u, int v) {
        for(int x=1; x<=n; ++x) inblossom[x] = false;
        newRoot = lca(u, v);
        trace(u); trace(v);
        if (root[u] != newRoot) dad[u] = v;
        if (root[v] != newRoot) dad[v] = u;
        for(int x=1; x<=n; ++x) if (inblossom[root[x]]) {
            root[x] = newRoot;
            if (!inque[x]) {
                inque[x] = true;
                que[qsize++] = x;
            }
        } }
    bool bfs() {
        for(int x=1; x<=n; ++x){
            inque[x] = false;
            dad[x] = 0;
            root[x] = x;
        }
        qsize = 0;
        que[qsize++] = start;
        inque[start] = true;
        finish = 0;
        for(int i=0; i<qsize; ++i) {
            int u = que[i];
            for (int e = last[u]; e != -1; e = next[e]) {
                int v = adj[e];
                if (root[v] != root[u] && v != mat[u]) {
                    if (v == start || (mat[v] > 0 && dad[mat[v]] > 0)) blossom(u, v);
                    else if (dad[v] == 0) {
                        dad[v] = u;
                        if (mat[v] > 0) que[qsize++] = mat[v];
                        else {
                            finish = v;
                            return true;
                        }
                    } }
            } }
        return false;
    }
    void enlarge() {
        int u = finish;
        while (u > 0) {
            int v = dad[u], x = mat[v];
            mat[v] = u;
            mat[u] = v;
            u = x;
        } 
    }
    int maxmat() {
        for(int x=1; x<=n; ++x) if (mat[x] == 0) {
            start = x;
            if (bfs()) enlarge();
        }
        int ret = 0;
        memset(fr, true, sizeof(fr));

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= n; j++) {
                if (i != j) {
                    li[i].insert(j);
                }
            }
        }
        
        int mx[300], my[300];
        int cnt = 0;
        for(int x=1; x<=n; ++x) {
            if (mat[x] > x){  
                ++ret;
                last[x] = mat[x];
                fr[x] = false;
                fr[mat[x]] = false;
                li[x].erase(mat[x]);
                li[mat[x]].erase(x);
                cnt ++;
                mx[cnt] = x;
                my[cnt] = mat[x];
            }
        }


        for (int x = 1; x <= n; x++) {
            if (fr[x]) {
                for (auto y : li[x]) {
                    if (!fr[y]) continue;
                    fr[x] = false;
                    fr[y] = false;
                    li[x].erase(y);
                    li[y].erase(x);
                    last[x] = y;
                    last[y] = x;

                    cnt++;
                    mx[cnt] = x;
                    my[cnt] = y;
                    break;
                }
            }
        }

        cout << "YES" << endl;

        cout << ret << endl;

        for (int i = 1; i <= n - 2; i++) {
            memset(fr, true, sizeof(fr));
            for (int x = 1; x <= n; x++) {
                if (fr[x]) {
                    for (auto y : li[x]) {
                        if (!fr[y]) continue;
                        fr[x] = false;
                        fr[y] = false;
                        li[x].erase(y);
                        li[y].erase(x);
                        cout << x << " " << y << endl;
                        break;
                    }
                }
            }
            cout << "--" << endl;
        }

        for (int i = 1; i <= cnt; i++) {
            cout << mx[i] << " " << my[i] << endl;
        }


        return ret;

    }
} edmonds;

int main() {
    freopen("input.txt", "r", stdin);
    int n, m, u, v, k;
    scanf("%d %d", &n, &k);
    n = 2*n;
    edmonds.init(n);
    for (int i = 1; i <= k; i++) {
        scanf("%d %d", &u, &v);

        edmonds.add(u, v);
        edmonds.add(v, u);
    }
    edmonds.maxmat();
}

