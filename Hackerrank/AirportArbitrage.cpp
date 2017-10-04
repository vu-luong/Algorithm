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
#include <queue>
#include "cs50.h"

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
const float eps = 0.001f;


int m, n;
vector< pair<int, float> > adj[MAXN];
bool fr[MAXN];
int ver[MAXN];
queue< pair<int, float> > q;
float dis[MAXN];

int main() {
    // freopen("AirportArbitrage.txt", "r", stdin);

    scanf("%d", &m);

    memset(fr, false, sizeof(fr));

    n = 0;

    for (int i = 1; i <= m; i++) {
        int u, v;
        float x;
        scanf("%d %d %f", &u, &v, &x);
        adj[u].PB(MP(v, x));
        // adj[v].PB(MP(u, x));

        if (!fr[u]) {
            fr[u] = true;
            n++;
            ver[n] = u;
        }

        if (!fr[v]) {
            fr[v] = true;
            n++;
            ver[n] = v;
        }
    }

    memset(fr, true, sizeof(fr));

    for (int i = 1; i <= n; i++){
        if (fr[ver[i]]) {

            q.push(MP(ver[i], 1));
            fr[ver[i]] = false;
            while (!q.empty()) {
                pair< int, float > cur  = q.front(); q.pop();
                int u = cur.first;
                float x = cur.second;

                for (int j = 0; j < adj[u].size(); j++) {
                    int v = adj[u][j].first;
                    float kc = adj[u][j].second;

                    if (fr[v]) {
                        q.push(MP(v, x * kc));
                        fr[v] = false;
                        dis[v] = x * kc;
                    } else {
                        if (abs(dis[v] - x * kc) >= eps) {
                            cout << 0 << endl;
                            return 0;
                        }
                    }
                }

            }

        }

    }

    cout << 1 << endl;
}
