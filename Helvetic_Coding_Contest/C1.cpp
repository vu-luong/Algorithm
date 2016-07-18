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
const int MAXN = 1005;
vector<int> adj[MAXN];
int m, n;
bool fr[MAXN];
int cnt;

void dfs(int u) {
    fr[u] = false;
    cnt++;

    for (int i = 0; i < adj[u].size(); i++) {
        int v = adj[u][i];

        if (fr[v]) dfs(v);
    }

}

int main() {
    // freopen("C1.txt", "r", stdin);

    scanf("%d %d", &n, &m);

    for (int i = 1; i <= m; i++) {
        int u, v;
        scanf("%d %d", &u, &v);
        adj[u].PB(v);
        adj[v].PB(u);
    }

    if (m != n - 1) {
        cout << "no";
        return 0;
    }
    memset(fr, true, sizeof(fr));
    cnt = 0;
    dfs(1);

    if (cnt == n) {
        cout << "yes" << endl;
    } else {
        cout << "no" << endl;
    }

}
