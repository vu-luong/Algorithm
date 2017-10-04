#include <map>
#include <set>
#include <cmath>
#include <cstdio>
#include <vector>
#include <string>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <algorithm>

#define PB push_back
#define MP make_pair
#define SZ(a) a.size()
#define DEBUG(x) cout << #x << " = " << x << endl;

#define PR(A,n)  { cout << #A << " = "; for (int i = 1, _n = (n); i <= _n; i++) \
cout << A[i] << ' '; cout << endl; }
#define PR0(A,n) { cout << #A << " = "; for (int i = 0, _n = (n); i < _n; i++) \
cout << A[i] << ' '; cout << endl; }

using namespace std;
const int MAXN = (int) 1e5 + 5;
const int inf = (int) 1e9 + 7;

int n, C;
int s[MAXN], p[MAXN];
vector< int > adj[MAXN];
bool fr[MAXN];
int st[MAXN];
int top;
int sum[MAXN];
int it[MAXN * 8];
int ans;
int res;
int sump[MAXN];

void update(int x, int l, int r, int u, int value) {
    if (l == r && r == u) {
        it[x] = value;
        return;
    }
    
    if (l > u || r < u) return;
    
    int mid = (l + r) / 2;
    update(2 * x, l, mid, u, value);
    update(2 * x +1, mid + 1, r, u, value);
    it[x] = min(it[x * 2], it[x * 2 + 1]);
}

void query(int x, int l, int r, int u, int v) {
    if (u <= l && r <= v) {
        ans = min(ans, it[x]);
        return;
    }
    
    if (r < u || l > v) return;
    
    int mid = (l + r) / 2;
    query(x *2, l, mid, u, v);
    query(x * 2 + 1, mid + 1, r, u, v);
}

void dfs(int u) {
    fr[u] = false;
    
    top++;
    st[top] = u;
    sum[top] = sum[top - 1] + s[u];
    sump[top] = sump[top - 1] + p[u];
    //update
    update(1, 0, n, top, sump[top]);
    
    int first = 0;
    int last = top + 1;
    while (first + 1 < last) {
        int mid = (first + last) / 2;
        
        if (sum[mid] >= sum[top] - C)
            last = mid;
        else first = mid;
    }
    
    ans = inf;
    query(1, 0, n, last, top - 1);
    res = max(res, sump[top] - ans);
    
    for (int i = 0; i < adj[u].size(); i++) {
        int v = adj[u][i];
        
        if (fr[v]) {
            dfs(v);
        }
        
    }
    
    update(1, 0, n, top, inf);
    top--;
}

int main() {
//    freopen("L.txt", "r", stdin);
    
    cin >> n >> C;
    for (int i = 1; i <= n; i++) {
        cin >> s[i];
    }
    
    for (int i = 1; i <= n; i++) {
        cin >> p[i];
    }
    
    for (int i = 1; i <= n - 1; i++) {
        int u, v;
        cin >> u >> v;
        
        adj[u].PB(v);
        adj[v].PB(u);
    }
    memset(fr, true, sizeof(fr));
    
    for (int i = 1; i <= 8*n; i++) {
        it[i] = 0;
    }
    
    res = -inf;
    dfs(1);
    
    cout << res;
    
}
