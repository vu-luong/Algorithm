#include <iostream>
#include <vector>
#include <cstring>
using namespace std;

const int MAXN = 200005;
const int oo = MAXN * 10000 + 1;

struct TLink { int v, w; };

TLink next[MAXN];
vector <int> prev[MAXN];
vector < vector <int> > C;
int par[MAXN], money[MAXN];
bool avail[MAXN];
int n, res = 0;

void Visit(int u) {
    if (!avail[u]) return;
    avail[u] = false;
    for (int i = 0; i < prev[u].size(); i++)
        Visit(prev[u][i]);

    money[next[u].v] += next[u].w;
    res += max(0, next[u].w - money[u]);
}

int main() {
    scanf("%d", &n);
    for (int i = 1; i <= n; i++) {
        scanf("%d %d", &next[i].v, &next[i].w);
        prev[next[i].v].push_back(i);
    }

    memset(avail, true, sizeof(avail));
    for (int i = 1; i <= n; i++)
        if (par[i] == 0) {
            int u = i;
            while (par[u] == 0) {
                par[u] = i;
                u = next[u].v;
            }
            if (par[u] != i) continue;

            vector <int> T;
            while (avail[u]) {
                avail[u] = false;
                T.push_back(u);
                u = next[u].v;
            }
            C.push_back(T);
        }

    for (int i = 1; i <= n; i++) Visit(i);

    for (int c = 0; c < C.size(); c++) {
        int minW = oo, start;
        for (int i = 0; i < C[c].size(); i++) {
            int u = C[c][i];
            int W = max(0, next[u].w - money[u]);
            if (W < minW) minW = W, start = u;
        }

        res += minW;
        money[next[start].v] += next[start].w;

        for (int u = next[start].v; u != start; u = next[u].v) {
            money[next[u].v] += next[u].w;
            res += max(0, next[u].w - money[u]);
        }
    }

    printf("%d", res);
}
