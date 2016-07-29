#include <iostream>
using namespace std;

const int MAXN = 11, MAXM = 1001;

int f[MAXN][MAXM];
int T, n, m;

inline int CalBit(int x) {
    for (int i = 11; i >= 0; i--)
        if (x & (1 << i)) return i + 1;
}

int main() {
    int i, j, k;
    for (i = 1; i < MAXN; i++) f[i][1] = 1;
    for (i = 1; i < MAXM; i++) f[1][i] = i;
    for (i = 2; i < MAXN; i++)
        for (j = 2; j < MAXM; j++) {
            f[i][j] = MAXM + 1;
            for (k = 1; k <= j; k++)
                f[i][j] = min(f[i][j], 1 + max(f[i - 1][k - 1], f[i][j - k]));
        }

    scanf("%d", &T);
    while (T--) {
        scanf("%d %d", &n, &m);

        int res;
        if (n < MAXN) res = f[n][m];
        else res = CalBit(m);

        printf("%d\n", res);
    }
}
