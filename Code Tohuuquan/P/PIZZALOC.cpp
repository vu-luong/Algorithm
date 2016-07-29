#include <iostream>
#define FR(i, a, b) for(int i = a; i < b; i++)
#define sqr(x) ((x) * (x))
#define dist(x1, y1, x2, y2) (sqr(x1 - x2) + sqr(y1 - y2))
using namespace std;

const int MAXM = 25, MAXN = 105, MAXK = MAXM;

struct TPizza { int x, y; };
struct TPlace { int x, y, s; };

TPizza a[MAXM];
TPlace b[MAXN];
bool f[MAXM][MAXN];
int c[MAXN];
int m, n, k, r, res = 0, sum = 0;

void Try(int x, int num) {
    FR(i, x + 1, m - num) {
        FR(j, 0, n)
            if (f[i][j]) {
                if (c[j] == 0) sum += b[j].s;
                ++c[j];
            }

        if (num > 0) Try(i, num - 1);
        else res = max(res, sum);

        FR(j, 0, n)
            if (f[i][j]) {
                --c[j];
                if (c[j] == 0) sum -= b[j].s;
            }
    }
}

int main() {
    scanf("%d %d", &k, &r);
    scanf("%d", &m);
    FR(i, 0, m) scanf("%d %d", &a[i].x, &a[i].y);
    scanf("%d", &n);
    FR(i, 0, n) scanf("%d %d %d", &b[i].x, &b[i].y, &b[i].s);

    FR(i, 0, m) FR(j, 0, n)
        f[i][j] = dist(a[i].x, a[i].y, b[j].x, b[j].y) <= sqr(r);

    Try(-1, k - 1);

    printf("%d", res);
}
