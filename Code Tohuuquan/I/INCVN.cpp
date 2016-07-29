#include <iostream>
#include <algorithm>
#include <cstring>
using namespace std;

const int MAXK = 52, MAXN = 10005;
const int radix = 5000000;

int s[MAXN], a[MAXN], b[MAXN], f[MAXK][MAXN];
int n, k, res = 0;

bool cmp(int u, int v) { return s[u] < s[v]; }

inline int Get(int x) {
    int res = 0;
    while (x > 0) {
        res = (res + a[x]) % radix;
        x -= x & -x;
    }
    return res;
}

inline void Update(int x, int value) {
    while (x <= n) {
        a[x] = (a[x] + value) % radix;
        x += x & -x;
    }
}

int main() {
    scanf("%d %d", &n, &k);
    for (int i = 0; i < n; i++) scanf("%d", s + i), a[i] = i;
    sort(a, a + n, cmp);
    b[a[0]] = 1;
    for (int i = 1; i < n; i++)
        b[a[i]] = b[a[i - 1]] + (s[a[i]] != s[a[i - 1]]);

    for (int j = 0; j < n; j++) f[1][j] = 1;
    for (int i = 2; i <= k; i++) {
        memset(a, 0, sizeof(a));
        for (int j = 0; j < n; j++) {
            f[i][j] = (f[i][j] + Get(b[j] - 1)) % radix;
            Update(b[j], f[i - 1][j]);
        }
    }

    for (int i = 0; i < n; i++)
        res = (res + f[k][i]) % radix;
    printf("%d", res);
}
