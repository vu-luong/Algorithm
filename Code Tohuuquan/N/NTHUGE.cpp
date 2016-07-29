#include <iostream>
#include <algorithm>
using namespace std;

typedef long long int64;

const int MAXN = 35;
const int MAXM = (1 << 16) + 10;
const int64 oo = -(int64)1e18;

struct TInfo { int64 weight, value; };
struct TNode { int64 minW, maxW, value; };

int64 v[MAXN], w[MAXN];
int64 L, R;
int bit[MAXN / 2];
TInfo a[MAXM];
TNode node[MAXM * 3];
int n, n1, n2, m;
int64 res = 0;

void Enter() {
    scanf("%d %lld %lld", &n, &L, &R);
    for (int i = 1; i <= n; i++)
        scanf("%lld %lld", w + i, v + i);
}

bool cmp(const TInfo u, const TInfo v) {
    return u.weight < v.weight;
}

void Init() {
    n1 = (n + 1) / 2;
    n2 = n - n1;
    bit[1] = 1;
    for (int i = 2; i <= n1 + 1; i++)
        bit[i] = bit[i - 1] << 1;
    m = bit[n1 + 1] - 1;

    for (int i = 0; i <= m; i++) {
        a[i].weight = a[i].value = 0;
        for (int j = 1; j <= n1; j++)
            if (i & bit[j]) {
                a[i].weight += w[j];
                a[i].value += v[j];
            }
    }
    sort(a, a + m + 1, cmp);
}

void Modify(int i, int left, int right) {
    if (left > right) return;
    if (left == right) {
        node[i].minW = node[i].maxW = a[left].weight;
        node[i].value = a[left].value;
        return;
    }
    int mid = (left + right) / 2;
    Modify(i * 2, left, mid);
    Modify(i * 2 + 1, mid + 1, right);
    node[i].minW = node[i * 2].minW;
    node[i].maxW = node[i * 2 + 1].maxW;
    node[i].value = max(node[i * 2].value, node[i * 2 + 1].value);
}

int64 Find(int i, int left, int right, const int64 wL, const int64 wR) {
    if (left > right) return oo;
    if (node[i].minW > wR || node[i].maxW < wL) return oo;
    if (wL <= node[i].minW && node[i].maxW <= wR) return node[i].value;

    int mid = (left + right) / 2;
    return max(Find(i * 2, left, mid, wL, wR),
               Find(i * 2 + 1, mid + 1, right, wL, wR));
}

void Solve() {
    Modify(1, 0, m);
    for (int i = 0; i < bit[n2 + 1]; i++) {
        int64 weight = 0, value = 0;
        for (int j = 1; j <= n2; j++)
            if (i & bit[j]) {
                weight += w[n1 + j];
                value += v[n1 + j];
            }

        res = max(res, value + Find(1, 0, m, L - weight, R - weight));
    }

    printf("%lld", res);
}

int main() {
    Enter();
    Init();
    Solve();
}
