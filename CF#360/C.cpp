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

using namespace std;

#define PB push_back
#define MP make_pair
#define SZ(a) a.size()
#define DEBUG(x) cout << #x << " = " << x << endl;

#define FOR(i, a, b) for (int _b = (b), i = (a); i <= _b; i++)
#define FORD(i, a, b) for (int _b = (b), i = (a); i >= _b; i--)
#define REP(i, a) for (int i = 0, _a = (a); i < _a; i++)
#define FIT(it, v) for (typeof((v).begin()) it = (v).begin(); it != (v).end(); it++)

using namespace std;

const int MAXN = (int) 1e5 + 5;

int n, m;
vector<int> adj[MAXN];
bool fr[MAXN];
int num[MAXN];
int d1 = 0, d2 = 0;
int q1[MAXN], q2[MAXN];


void dfs(int u) {

    if (num[u] == 1) {
        d1++;
        q1[d1] = u;
    } else {
        d2++;
        q2[d2] = u;
    }
    fr[u] = false;

    FOR(i, 0, SZ(adj[u]) - 1) {
        int v = adj[u][i];

        if (num[v] != 0 && num[v] == num[u]) {
            cout << "-1";
            exit(0);
        } else {
            num[v] = 3 - num[u];

            if (fr[v]) dfs(v);
        }

    }

}

int main() {
    freopen("C.txt", "r", stdin);

    cin >> n >> m;

    for (int i = 1; i <= m; i++) {
        int u, v;
        cin >> u >> v;
        adj[u].PB(v);
        adj[v].PB(u);
    }

    memset(fr, true, sizeof(fr));

    FOR(i, 1, n) {
        if (fr[i]) {
            num[i] = 1;
            dfs(i);
        }
    }

    cout << d1 << endl;
    FOR(i, 1, d1) {
        cout << q1[i] << " ";
    }
    cout << endl;

    cout << d2 << endl;
    FOR(i, 1, d2) {
        cout << q2[i] << " ";
    }

}
