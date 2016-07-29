#include <iostream>
#include <algorithm>
#define FR(i, a, b) for(int i = a; i < b; i++)
using namespace std;

const int MAXN = 1010;

typedef long long int64;

int w[MAXN], d[MAXN], p[MAXN];
int64 g[MAXN];
int a1[MAXN], a2[MAXN], res[MAXN];
int n, t;

bool cmp1(int u, int v) { return w[u] < w[v]; }
bool cmp2(int u, int v) { return g[u] < g[v]; }

int main() {
    scanf("%d %d", &n, &t);
    FR(i, 0, n) scanf("%d", &w[i]);
    FR(i, 0, n) scanf("%d", &d[i]);
    FR(i, 0, n) scanf("%d", &p[i]);
    FR(i, 0, n) g[i] = p[i] - (int64)d[i] * t;

    FR(i, 0, n) a1[i] = a2[i] = i;
    sort(a1, a1 + n, cmp1);
    sort(a2, a2 + n, cmp2);

    FR(i, 0, n)
        res[a2[i]] = a1[i];

    FR(i, 0, n)
        printf("%d ", res[i] + 1);
}
