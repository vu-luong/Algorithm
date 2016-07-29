#include <iostream>
#include <algorithm>
#include <cstring>
using namespace std;

typedef long long int64;

const int MAXN = 250005;
const int BASE = 65536;

int a[MAXN], node[BASE + 1];
int nTests, seed, mul, add, n, k;

inline void Update(int x, int value) {
    while (x <= BASE) {
        node[x] += value;
        x += x & -x;
    }
}

inline int Sum(int x) {
    int res = 0;
    while (x > 0) {
        res += node[x];
        x -= x & -x;
    }
    return res;
}

int Find(int k) {
    int lo = 1, hi = BASE;
    while (lo < hi) {
        int mid = (lo + hi) / 2;
        if (k > Sum(mid))
            lo = mid + 1;
        else
            hi = mid;
    }
    return hi;
}

int main() {
    scanf("%d", &nTests);
    for (int t = 1; t <= nTests; t++) {
        scanf("%d %d %d %d %d", &seed, &mul, &add, &n, &k);
        a[1] = seed;
        for (int i = 2; i <= n; i++) {
            int64 t = ((int64)a[i - 1] * mul + add) % BASE;
            a[i] = t;
        }
        for (int i = 1; i <= n; i++) ++a[i];

        memset(node, 0, sizeof(node));
        for (int i = 1; i < k; i++) Update(a[i], 1);

        int64 res = 0;
        int l = (k + 1) / 2;
        for (int i = k; i <= n; i++) {
            Update(a[i], 1);
            res += Find(l) - 1;
            Update(a[i - k + 1], -1);
        }

        printf("Case #%d: %lld\n", t, res);
    }
}
