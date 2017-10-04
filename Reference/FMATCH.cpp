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
const int MAXN = (int) 5e4 + 5;
const int inf = (int) 1e9 + 7;
int n, m, p;
vector<int> adj[MAXN];
int dis[MAXN], matchX[MAXN], matchY[MAXN], q[MAXN];

bool findpath() {
    int first = 1;
    int last = 0;
    for (int i = 1; i <= n; i++) {
        if (matchX[i] == 0) {
            dis[i] = 0;
            last++;
            q[last] = i;
        } else dis[i] = inf;
    }
    dis[0] = inf;
    while (first <= last) {
        int u = q[first];
        first++;
        for (int i = 0; i < adj[u].size(); i++) {
            int v = adj[u][i];
            if (dis[matchY[v]] == inf) {
                dis[matchY[v]] = dis[u] + 1;
                if (matchY[v] != 0) {
                    last++;
                    q[last] = matchY[v];
                }
            }
        }
    }
    return dis[0] != inf;
}

bool dfs(int u) {
    if (u == 0) return true;
    for (int i = 0; i < adj[u].size(); i++){
        int v = adj[u][i];
        if (dis[matchY[v]] == dis[u] + 1) {
            if (dfs(matchY[v])) {
                matchX[u] = v;
                matchY[v] = u;
                return true;
            }
        }
    }
    dis[u] = inf;
    return false;
}

int main() {
    // freopen("FMATCH.txt", "r", stdin);

    scanf("%d %d %d", &n, &m, &p);

    for (int i = 1; i <= p; i++) {
        int u, v;
        scanf("%d %d", &u, &v);
        adj[u].PB(v);
    }

    memset(matchX, 0, sizeof(matchX));
    memset(matchY, 0, sizeof(matchY));
    int res = 0;
    while (findpath()) {
        for (int i = 1; i <= n; i++) {
            if (matchX[i] == 0) {
                if (dfs(i)) res++;
            }
        }
    }
    cout << res << endl;

}
