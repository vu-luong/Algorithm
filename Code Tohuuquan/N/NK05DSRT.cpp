#include <iostream>
#include <vector>
#include <queue>
#include <cstring>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

const int MAXN = 105, MAXM = 100;

struct TInfo {
    int v, l;
    TInfo() {}
    TInfo(int _v, int _l) { v = _v; l = _l; }
};

typedef long long int64;
typedef pair <int64, int> TNode;

const int64 MAXD = (int64)1e18;

vector <TInfo> head[MAXN];
int64 d[MAXN];
bool avail[MAXN];
int T, n, m, c;

void Enter() {
    scanf("%d %d %d", &n, &m, &c);
    FOR(i, 1, n) head[i].clear();
    FOR(i, 1, m) {
        int u, v, l;
        scanf("%d %d %d", &u, &v, &l);
        if (l <= c) {
            head[u].push_back(TInfo(v, l));
            head[v].push_back(TInfo(u, l));
        }
    }
}

inline int64 Cal(int64 s1, int d) {
    if (s1 + d > c && c <= d * 2) return MAXD;
    if (s1 + d <= c) return s1 + d;
    s1 -= c - d;
    int w = c - d * 2;
    return ((s1 - 1) / w + 1) * (c - w) + s1 + c;
}

void Solve() {
    priority_queue < TNode, vector <TNode>, greater <TNode> > Q;
    FOR(i, 1, n) d[i] = MAXD;
    memset(avail, true, sizeof(avail));
    d[n] = 0;
    Q.push(make_pair(d[n], n));

    while (Q.size()) {
        TNode u = Q.top(); Q.pop();
        if (!avail[u.second]) continue;
        if (u.second == 1) break;
        avail[u.second] = false;

        for (int i = 0; i < head[u.second].size(); i++) {
            int v = head[u.second][i].v;
            int64 dist = Cal(u.first, head[u.second][i].l);
            if (d[v] > dist) {
                d[v] = dist;
                Q.push(make_pair(d[v], v));
            }
        }
    }

    printf("%lld\n", d[1]);
}

int main() {
    scanf("%d", &T);
    while (T--) {
        Enter();
        Solve();
    }
}
