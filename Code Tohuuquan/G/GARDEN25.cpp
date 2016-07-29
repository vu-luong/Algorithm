#include <cstdio>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

const int MAXN = 255, MAXM = MAXN;

bool a[MAXM][MAXN];
int b[MAXM][MAXN], d[MAXM + MAXN], c[3];
int m, n, s;

int main() {
    scanf("%d %d", &m, &n);
    FOR(i, 1, m) FOR(j, 1, n) {
        scanf("%d", &a[i][j]);
        if (a[i][j]) ++d[i], ++d[j + m], ++s;
    }

    while (s) {
        int x = 0, color = c[1] < c[2] ? 1 : 2;
        FOR(i, 1, m + n) {
            if (d[i]) x = i;
            if (d[i] % 2) break;
        }

        while (true) {
            if (x <= m) {
                int y = 0;
                FOR(j, m + 1, m + n)
                    if (a[x][j - m]) { y = j; break;}
                if (y == 0) break;
                a[x][y - m] = false;
                b[x][y - m] = color;
                --s; --d[x]; --d[y]; ++c[color];
                x = y;
            }
            else {
                int y = 0;
                FOR(i, 1, m)
                    if (a[i][x - m]) { y = i; break; }
                if (y == 0) break;
                a[y][x - m] = false;
                b[y][x - m] = color;
                --s; --d[x]; --d[y]; ++c[color];
                x = y;
            }
            color = 3 - color;
        }
    }

    FOR(i, 1, m) {
        FOR(j, 1, n) printf("%d ", b[i][j]);
        printf("\n");
    }
}

