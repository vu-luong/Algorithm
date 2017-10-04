#include <bits/stdc++.h>

using namespace std;
const int MAXN = 555;
const int oo = (int) 1e9 + 7;

int n, nf, m;

int f[MAXN];
vector< pair<int, int> > adj[MAXN];
int d[MAXN];
priority_queue< pair<int, int> > q;
bool fr[MAXN];
int res, pos;


void dijkstra(int ss) {

    for (int i = 1; i <= n; i++) {
        d[i] = oo;
    }

    memset(fr, true, sizeof(fr));
    d[ss] = 0;

    q.push({0, ss});

    while (!q.empty()) {
        int u = q.top().second;
        q.pop();
        fr[u] = false;

        for (int i = 0; i < adj[u].size(); i++) {
            int v = adj[u][i].first;
            if (!fr[v]) continue;

            if (d[v] > d[u] + adj[u][i].second) {
                d[v] = d[u] + adj[u][i].second;
                q.push({-d[v], v});
            }
        }
    }

    int sum = 0;

    for (int i = 1; i <= nf; i++) {
        sum += d[f[i]];
    }

    if (sum < res) {
        res = sum;
        pos = ss;
    }

}

int main() {
//    freopen("BESTSPOT.txt", "r", stdin);
    scanf("%d %d %d", &n, &nf, &m);
    for (int i = 1; i <= nf; i++) {
        scanf("%d", &f[i]);
    }

    for (int i = 1; i <= m; i ++) {
        int u, v, value;
        scanf("%d %d %d", &u, &v, &value);
        adj[u].push_back({v, value});
        adj[v].push_back({u, value});
    }

    res = oo;
    pos = 0;

    for (int i = 1; i <= n; i++) {
        dijkstra(i);
    }

    for (int i = 1; i <= n; i++) {
        
    }

    cout << pos << endl;

}
