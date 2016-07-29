#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>
#include <cstring>
using namespace std;

const int MAXR = 55, MAXC = 15;
const int MAXN = MAXR * MAXC * 2 + 2;

struct TEdge {
    int x, y, c, f;

    TEdge(int _x, int _y, int _c) {
        x = _x; y = _y; c = _c; f = 0;
    }
};

vector <TEdge> e;
vector <int> head[MAXN];
int trace[MAXN];
int n, r, c, m, res = 0;

inline int ID(int x, int y) {
    return x + (y - 1) * r + 1;
}

void Enter() {
    scanf("%d %d", &r, &c);
    c *= 2; n = r * c + 2;

    for (int i = 1; i <= r; i++) {
        e.push_back(TEdge(1, ID(i, 1), 1));
        e.push_back(TEdge(ID(i, c), n, 1));
    }

    for (int i = 1; i <= r; i++)
        for (int j = 2; j <= c; j += 2)
            e.push_back(TEdge(ID(i, j - 1), ID(i, j), 1));

    for (int j = 3; j < c; j += 2)
        for (int i = 1; i <= r; i++) {
            int cnt, x; scanf("%d", &cnt);
            while (cnt--) {
                scanf("%d", &x);
                e.push_back(TEdge(ID(i, j - 1), ID(x, j), 1));
            }
        }

    m = e.size();
    for (int i = 0; i < m; i++)
        e.push_back(TEdge(e[i].y, e[i].x, 0));
    for (int i = 0; i < e.size(); i++)
        head[e[i].x].push_back(i);
}

bool FindPath() {
    memset(trace, -1, sizeof(trace));
    queue <int> Q;
    trace[1] = 0;
    Q.push(1);

    while (Q.size()) {
        int u = Q.front(); Q.pop();
        for (int j = 0; j < head[u].size(); j++) {
            int i = head[u][j], v = e[i].y;
            if (trace[v] == -1 && e[i].c > e[i].f) {
                trace[v] = i;
                if (v == n) return true;
                Q.push(v);
            }
        }
    }
    return false;
}

void IncFlow() {
    int v = n, delta = r;
    while (v != 1) {
        int i = trace[v];
        delta = min(delta, e[i].c - e[i].f);
        v = e[i].x;
    }

    v = n;
    while (v != 1) {
        int i = trace[v];
        e[i].f += delta;
        e[i + m].f -= delta;
        v = e[i].x;
    }

    res += delta;
}

void Solve() {
    while (FindPath()) IncFlow();
    printf("%d\n", res);
}

int main() {
    Enter();
    Solve();
}
