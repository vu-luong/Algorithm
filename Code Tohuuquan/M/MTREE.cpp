#include <iostream>
#include <vector>
using namespace std;

typedef long long int64;
typedef pair <int, int> TLink;

const int MAXN = 100005;
const int64 BASE = 1000000007;

vector <TLink> h[MAXN];
int p[MAXN];
int64 f[MAXN];
int n;

int64 Cal(int u) {
    int64 res = 0;
    f[u] = 1;
    for (int i = 0; i < h[u].size(); i++) {
        int v = h[u][i].first;
        int w = h[u][i].second;
        if (v != p[u]) {
            p[v] = u;
            res = (res + Cal(v)) % BASE;
            int64 sum = (w * f[v]) % BASE;
            res = (res + sum * f[u]) % BASE;
            f[u] = (f[u] + sum) % BASE;
        }
    }
    return res;
}

int main() {
    scanf("%d", &n);
    for (int i = 1; i < n; i++) {
        int x, y, w;
        scanf("%d %d %d", &x, &y, &w);
        h[x].push_back(TLink(y, w));
        h[y].push_back(TLink(x, w));
    }

    printf("%lld", Cal(1));
}
