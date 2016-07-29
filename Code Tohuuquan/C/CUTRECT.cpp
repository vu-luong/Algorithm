#include <iostream>
#include <vector>
#include <queue>
#include <cstring>
using namespace std;

typedef long long int64;
typedef pair <int64, int> TNode;

const int MAXR = 402, MAXC = 402;
const int MAXN = MAXR * MAXC + 2;
const int64 oo = (int64)1e18;

struct TLink {
    int v, w;
    TLink(int _v, int _w) {
        v = _v; w = _w;
    }
};

vector <TLink> h[MAXN];
bool avail[MAXN];
int64 d[MAXN];
int r, c, n, start, finish;

inline int ID(int x, int y) {
    return (y - 1) * r + x;
}

void MakeEdge(int u, int v, int w) {
    h[u].push_back(TLink(v, w));
    h[v].push_back(TLink(u, w));
}

void Enter() {
    scanf("%d %d", &r, &c); ++r; ++c;
    n = r * c + 2;
    start = n - 1;
    finish = n;

    for (int i = 2; i < r; i++) {
        MakeEdge(start, ID(i, 1), 0);
        MakeEdge(finish, ID(i, c), 0);
    }
    for (int j = 2; j < c; j++) {
        MakeEdge(start, ID(r, j), 0);
        MakeEdge(finish, ID(1, j), 0);
    }

    for (int i = 1; i < r; i++)
        for (int j = 2; j < c; j++) {
            int x; scanf("%d", &x);
            MakeEdge(ID(i, j), ID(i + 1, j), x);
        }
    for (int i = 2; i < r; i++)
        for (int j = 1; j < c; j++) {
            int x; scanf("%d", &x);
            MakeEdge(ID(i, j), ID(i, j + 1), x);
        }
}

void Solve() {
    for (int i = 1; i <= n; i++) d[i] = oo;
    memset(avail, true, sizeof(avail));

    priority_queue < TNode, vector <TNode>, greater <TNode> > Q;
    d[start] = 0;
    Q.push(TNode(0, start));

    while (Q.size()) {
        int64 D = Q.top().first;
        int u = Q.top().second;
        Q.pop();
        if (!avail[u]) continue;
        avail[u] = false;

        if (u == finish) break;

        for (int i = 0; i < h[u].size(); i++) {
            int v = h[u][i].v, w = h[u][i].w;
            if (avail[v] && d[v] > d[u] + w) {
                d[v] = d[u] + w;
                Q.push(TNode(d[v], v));
            }
        }
    }
}

void Print() {
    if (d[finish] == oo) d[finish] = -1;
    printf("%lld", d[finish]);
}

int main() {
    Enter();
    Solve();
    Print();
}
