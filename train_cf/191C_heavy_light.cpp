#include <bits/stdc++.h>

#define PB push_back
#define MP make_pair
#define SZ(a) a.size()
#define DEBUG(x) cout << #x << " = " << x << endl;

#define PR(A,n)  { cout << #A << " = "; for (int i = 1, _n = (n); i <= _n; i++) \
                    cout << A[i] << ' '; cout << endl; }
#define PR0(A,n) { cout << #A << " = "; for (int i = 0, _n = (n); i < _n; i++) \
                    cout << A[i] << ' '; cout << endl; }

using namespace std;

const int MAXN = 100005;

vector< pair<int, int> > adj[MAXN];
bool fr[MAXN];
int parent[MAXN];
int n;
int level[MAXN];
int k;
int p[MAXN][25];
int chainHead[MAXN];
int chainInd[MAXN];
int nChain;
int nBase;
int posInBase[MAXN];
int nChild[MAXN];
int IT[MAXN * 8], T[MAXN * 8];
int res = -1;
int edge[MAXN];


void dfs(int u) {

    int cntChild = 0;
    for (int i = 0; i < adj[u].size(); i++) {
        int v = adj[u][i].first;
        int id = adj[u][i].second;

        if (fr[v]) {
            cntChild++;
            fr[v] = false;
            parent[v] = u;
            edge[id] = v;
            level[v] = level[u] + 1;
            dfs(v);
            nChild[u] += nChild[v];
        }
    }

    nChild[u]++;
}

int getbit(int x, int k) {
    return (x >> k) & 1;
}

int lca(int x, int y) {
    for (int i = k; i >= 0; i--) {
        if (level[p[x][i]] >= level[y]) {
            x = p[x][i];
        }
    }

    for (int i = k; i >= 0; i--) {
        if (level[p[y][i]] >= level[x]) {
            y = p[y][i];
        }
    }

    for (int i = k; i >= 0; i--) {
        if (p[x][i] != p[y][i]) {
            x = p[x][i];
            y = p[y][i];
        }
    }

    while (x != y) {
        x = p[x][0];
        y = p[y][0];
    }

    return x;
}

void updateIT(int x, int l, int r, int u, int v, int value) {
    if (T[x] > 0) {
        IT[x] += T[x];
        T[2 * x] += T[x];
        T[2 * x + 1] += T[x];
        T[x] = 0;
    }

    if (r < u || l > v) return;

    if (u <= l && r <= v) {
        IT[x] += value;
        T[2 * x] += value;
        T[2 * x + 1] += value;
        T[x] = 0;
        return;
    }

    int mid = (l + r) / 2;
    updateIT(x * 2, l, mid, u, v, value);
    updateIT(x * 2 + 1, mid + 1, r, u, v, value);

    IT[x] = max(IT[x * 2], IT[x * 2 + 1]);
}

void getmax(int x, int l, int r, int u, int v) {
    if (T[x] > 0) {
        IT[x] += T[x];
        T[2 * x] += T[x];
        T[2 * x + 1] += T[x];
        T[x] = 0;
    }

    if (r < u || l > v) return;

    if (u <= l && r <= v) {
        if (IT[x] > res) res = IT[x];
        return;
    }

    int mid = (l + r) / 2;

    getmax(x * 2, l, mid, u, v);
    getmax(x * 2 + 1, mid + 1, r , u, v);
}

void hld(int u) {

    if (chainHead[nChain] == 0) chainHead[nChain] = u;

    chainInd[u] = nChain;

    posInBase[u] = ++nBase;

    int mxVtx = -1;

    for (int i = 0; i < adj[u].size(); i++) {
        int v = adj[u][i].first;
        if (v != parent[u]) {
            if (mxVtx == -1 || nChild[v] > nChild[mxVtx]) {
                mxVtx = v;
            }
        }
    }

    if (mxVtx > - 1) {
        hld(mxVtx);
    }

    for (int i = 0; i < adj[u].size(); i++) {
        int v = adj[u][i].first;

        if (v != parent[u] && v != mxVtx) {
            nChain++;
            hld(v);
        }
    }
}

void update(int u, int a, int value) {

    int uchain = chainInd[u], achain = chainInd[a];


    

    while (1) {
        if (uchain == achain) {
            if (posInBase[a] <= posInBase[u]) {                
                updateIT(1, 1, n, posInBase[a], posInBase[u], value);
            } else {
                updateIT(1, 1, n, posInBase[u], posInBase[a], value);
            }
            
            break;
        }


        if (posInBase[chainHead[uchain]] <= posInBase[u])
            updateIT(1, 1, n, posInBase[chainHead[uchain]], posInBase[u], value);
        else
            updateIT(1, 1, n, posInBase[u], posInBase[chainHead[uchain]], value);

        u = parent[chainHead[uchain]];
        uchain = chainInd[u];
    }
}



int main() {
    //freopen("191C.txt", "r", stdin);
    
    scanf("%d", &n);
    for (int i = 1; i <= n - 1; i++) { 
        int u, v;
        scanf("%d %d", &u, &v);
        adj[u].push_back({v, i});
        adj[v].push_back({u, i});
    }

    k = trunc(log(n) / log(2));
    
    memset(fr, true, sizeof(fr));
    fr[1] = false;
    parent[1] = -1;
    level[1] = 1;
    dfs(1);

    for (int i = 1; i <= n; i++) {
        p[i][0] = parent[i];
    }

    for (int j = 1; j <= k; j++) {
        for (int i = 1; i <= n; i++) {
            if (p[i][j - 1] == - 1) continue;
            p[i][j] = p[p[i][j - 1]][j - 1];
        }
    }

    nChain = 1;
    nBase = 0;
    hld(1);


    int q;
    scanf("%d", &q);
    for (int i = 1; i <= q; i++) {
        int u, v;
        scanf("%d %d", &u, &v);

        int lc = lca(u, v);

        update(u, lc, 1);
        update(v, lc, 1);
        update(lc, lc, -2);
    }

    for (int i = 1; i <= n - 1; i++) {
        int pos = edge[i];
        int base = posInBase[pos];
        res = -1;
        getmax(1, 1, n, base, base);
        cout << res << " ";
    }
}
