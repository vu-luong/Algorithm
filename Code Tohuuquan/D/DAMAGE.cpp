#include <iostream>
#include <vector>
#include <queue>
#include <cstring>
using namespace std;

const int MAXN = 30005;

vector <int> h[MAXN];
bool avail[MAXN];
int n, m, k;

int main() {
    scanf("%d %d %d", &n, &m, &k);
    for (int i = 0; i < m; i++) {
        int u, v; scanf("%d %d", &u, &v);
        h[u].push_back(v);
        h[v].push_back(u);
    }
    memset(avail, true, sizeof(avail));
    queue <int> Q;
    for (int i = 0; i < k; i++) {
        int u; scanf("%d", &u);
        avail[u] = false; Q.push(u);
    }

    while (Q.size()) {
        int u = Q.front(); Q.pop();
        for (int i = 0; i < h[u].size(); i++)
            avail[h[u][i]] = false;
    }

    int res = n;
    if (avail[1]) {
        avail[1] = false; Q.push(1);
        while (Q.size()) {
            --res;
            int u = Q.front(); Q.pop();
            for (int i = 0; i < h[u].size(); i++) {
                int v = h[u][i];
                if (avail[v]) {
                    avail[v] = false;
                    Q.push(v);
                }
            }
        }
    }
    printf("%d", res);
}
