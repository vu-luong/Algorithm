#include <cstdio>
#include <cstring>
using namespace std;

const int MAXN = 2005;

bool a[MAXN][MAXN];
int sumR[MAXN][MAXN], sumC[MAXN][MAXN], pos[MAXN][MAXN];
int cnt[MAXN], h[MAXN], p[MAXN];
int N, M, X0, A, B, Y0, C, D, res = 0;

inline bool isPerfect(int lx, int ly, int rx, int ry) {
    return sumR[lx - 1][ry] != sumR[lx - 1][ly - 1] &&
           sumR[rx + 1][ry] != sumR[rx + 1][ly - 1] &&
           sumC[ly - 1][rx] != sumC[ly - 1][lx - 1] &&
           sumC[ry + 1][rx] != sumC[ry + 1][lx - 1];
}

int main() {
    scanf("%d %d %d %d %d %d %d %d", &N, &M, &X0, &A, &B, &Y0, &C, &D);
    X0 %= N, Y0 %= N;
    A %= N, B %= N;
    C %= N, D %= N;

    for (int i = 0; i < M; i++) {
        a[X0 + 1][Y0 + 1] = true;
        X0 = (X0 * A + B) % N;
        Y0 = (Y0 * C + D) % N;
    }

    for (int i = 0; i <= N + 1; i++)
        a[0][i] = a[N + 1][i] = a[i][0] = a[i][N + 1] = true;

    for (int i = 0; i <= N + 1; i++) {
        sumR[i][0] = a[i][0];
        for (int j = 1; j <= N + 1; j++)
            sumR[i][j] = sumR[i][j - 1] + a[i][j];
    }
    for (int j = 0; j <= N + 1; j++) {
        sumC[j][0] = a[0][j];
        for (int i = 1; i <= N + 1; i++)
            sumC[j][i] = sumC[j][i - 1] + a[i][j];
    }

    for (int i = 0; i <= N + 1; i++) {
        for (int j = 0; j <= N + 1; j++)
            if (!a[i][j]) ++h[j]; else h[j] = 0;

        memset(cnt, 0, sizeof(cnt));
        for (int j = 0; j <= N + 1; j++)
            pos[h[j]][cnt[h[j]]++] = j;

        memset(p, -1, sizeof(p));

        int L = -1, R = -1;
        for (int height = N + 1; height > 0; height--)
            for (int it = 0; it < cnt[height]; it++) {
                int pp = pos[height][it];
                L = p[pp - 1] == -1 ? pp : p[pp - 1];
                R = p[pp + 1] == -1 ? pp : p[pp + 1];
                p[L] = R; p[R] = L;
                if (isPerfect(i - height + 1, L, i, R)) ++res;
            }
    }

    printf("%d", res);
}
