#include <cstdio>
#include <cstring>
#define FR(i, a, b) for(int i = a; i < b; i++)
using namespace std;

typedef long long int64;

int64 f[4][2][2];
int nTests, n, x, y;
int64 res;

int main() {
    scanf("%d", &nTests);
    while (nTests--) {
        scanf("%d", &n);

        memset(f, 0, sizeof(f));
        FR(i, 0, n) {
            scanf("%d %d", &x, &y);
            if (x != 0 && y != 0)
                ++f[2 * (x < 0) + (y < 0)][x & 1][y & 1];
        }

        res = 0;
        FR(x1, 0, 2) FR(y1, 0, 2)
            FR(x2, 0, 2) FR(y2, 0, 2)
                FR(x3, 0, 2) FR(y3, 0, 2)
                    FR(x4, 0, 2) FR(y4, 0, 2) {
                        int t = (x2 - x1) * (y3 - y1) - (x3 - x1) * (y2 - y1) +
                                (x2 - x4) * (y3 - y4) - (x3 - x4) * (y2 - y4);
                        if (t % 2 == 0)
                            res += f[0][x1][y1] * f[1][x2][y2]
                                 * f[2][x3][y3] * f[3][x4][y4];
                    }

        printf("%lld\n", res);
    }
}
