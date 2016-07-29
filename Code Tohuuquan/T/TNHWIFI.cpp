#include <cstdio>
#include <cmath>
#include <algorithm>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

const int MAXM = 30005;
const int MAXN = 1005;

int d[MAXM][MAXN];
int M, N, K, res, cnt;

int main() {
    scanf("%d %d %d", &M, &N, &K);

    for (int k = 0; k < K; k++) {
        int x, y, r, b;
        scanf("%d %d %d %d", &y, &x, &r, &b);

        FOR(j, max(1, y - r), min(N, y + r)) {
            int dx, dy, lo, hi;
            dy = j - y;
            dx = (int)sqrt(r * r - dy * dy);
            lo = max(1, x - dx);
            hi = min(M, x + dx);

            d[lo][j] += b;
            d[hi + 1][j] -= b;
        }
    }

    res = 0;
    cnt = M * N;

    FOR(i, 1, M) FOR(j, 1, N) {
        d[i][j] += d[i - 1][j];
        if (d[i][j] > res) res = d[i][j], cnt = 0;
        cnt += d[i][j] == res;
    }

    printf("%d\n%d", res, cnt);
}
