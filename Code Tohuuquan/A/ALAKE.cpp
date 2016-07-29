#include <iostream>
using namespace std;

typedef long long int64;

const int MAXN = (int)1e5 + 5;
const int oo = (int)1e9;

int w[MAXN], h[MAXN], prev[MAXN], next[MAXN];
int64 res[MAXN];
int n, x = 0;
int64 s;

int main() {
    scanf("%d", &n);
    h[0] = h[n + 1] = oo;
    for (int i = 1; i <= n; i++) {
        scanf("%d %d", &w[i], &h[i]);
        prev[i] = i - 1;
        next[i] = i + 1;
        if (h[i] < h[x]) x = i;
    }

    while (h[x] < oo) {
        res[x] = s + w[x];
        next[prev[x]] = next[x];
        prev[next[x]] = prev[x];
        if (h[prev[x]] < h[next[x]]) {
            int y = prev[x];
            s += (int64)w[x] * (h[y] - h[x]);
            w[y] += w[x];
            x = y;
            while (x > 0 && h[prev[x]] < h[x]) x = prev[x];
        }
        else {
            int y = next[x];
            s += (int64)w[x] * (h[y] - h[x]);
            w[y] += w[x];
            x = y;
            while (x <= n && h[next[x]] < h[x]) x = next[x];
        }
    }

    for (int i = 1; i <= n; i++)
        printf("%lld\n", res[i]);
}
