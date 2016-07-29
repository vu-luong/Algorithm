#include <cstdio>
#include <vector>
#include <algorithm>
using namespace std;

const int MAXN = 100005;

struct TLink {
    int v, a, b;

    TLink() {}
    TLink(int _v, int _a, int _b) {
        v = _v; a = _a; b = _b;
    }
};

vector <TLink> h[MAXN];
int d[MAXN], par[MAXN];
int n, k, money;

void Enter() {
    scanf("%d %d", &n, &k);
    for (int i = 1; i < n; i++) {
        int x, y, a, b;
        scanf("%d %d %d %d", &x, &y, &a, &b);
        h[x].push_back(TLink(y, a, b));
        h[y].push_back(TLink(x, a, b));
    }
}

int Cal(int u) {
    d[u] = 0;
    vector <TLink> :: iterator e;
    for (e = h[u].begin(); e != h[u].end(); e++)
        if (e->v != par[u]) {
            par[e->v] = u;
            d[u] = max(d[u], Cal(e->v) + e->a);
        }
    return d[u];
}

bool Check(int u, int dist) {
    if (dist < 0 || money < 0) return false;
    vector <TLink> :: iterator e;
    for (e = h[u].begin(); e != h[u].end(); e++)
        if (e->v != par[u] && e->a + d[e->v] > dist) {
            int delta = min(e->a - e->b, e->a + d[e->v] - dist);
            money -= delta;

            if (!Check(e->v, dist - e->a + delta))
                return false;
        }
    return true;
}

void Solve() {
    int lo = 0, hi = Cal(1);
    while (lo <= hi) {
        int mid = (lo + hi) >> 1;
        money = k;
        if (Check(1, mid))
            hi = mid - 1;
        else
            lo = mid + 1;
    }
    printf("%d", lo);
}

int main() {
    Enter();
    Solve();
}
