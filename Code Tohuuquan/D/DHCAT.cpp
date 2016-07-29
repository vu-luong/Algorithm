#include <cstdio>
#include <algorithm>
#define FOR(i, a, b)  for(int i = a; i <= b; i++)
#define LFOR(i, a, b) for(int i = a; i >= b; i--)
using namespace std;

const int MAXN = 21;
const int MAXM = MAXN * 2 - 1;
const int MAXS = 5000;
const int INF = (int)1e9;

int a[MAXM][MAXN], l[MAXN], f[MAXM][MAXN];
long long c[MAXM][MAXN][MAXS + 1];
int N, M, S;

void Enter() {
    scanf("%d %d", &N, &S);
    M = N * 2 - 1;
    FOR(i, 0, N - 1)
        l[N - i] = l[N + i] = i + 1;

    FOR(i, 1, M) FOR(j, 1, l[i])
        scanf("%d", &a[i][j]);
}

void MinPath() {
    FOR(j, 1, N) f[M][j] = a[M][j];

    // Lower triangle
    LFOR(i, M - 1, N) FOR(j, 1, l[i])
        f[i][j] = min(f[i + 1][j], f[i + 1][j + 1]) + a[i][j];

    // Upper triangle
    LFOR(i, N - 1, 1) {
        f[i][1]    = f[i + 1][1] + a[i][1];
        f[i][l[i]] = f[i + 1][l[i] - 1] + a[i][l[i]];

        FOR(j, 2, l[i] - 1)
            f[i][j] = min(f[i + 1][j - 1], f[i + 1][j]) + a[i][j];
    }

    int j = 1;
    FOR(i, 2, N)
        if (f[1][i] < f[1][j]) j = i;
    printf("%d\n", f[1][j]);

    printf("%d ", j - 1);
    // Upper triangle
    FOR(i, 1, N - 1)
        if (j > 1 && f[i][j] == f[i + 1][j - 1] + a[i][j])
            printf("L"), --j;
        else
            printf("R");

    // Lower triangle
    FOR(i, N, M - 1)
        if (f[i][j] == f[i + 1][j] + a[i][j])
            printf("L");
        else
            printf("R"), ++j;
    printf("\n");
}

void SPath() {
    FOR(j, 1, N)
        c[M][j][ a[M][j] ] = 1;

    // Lower triangle
    LFOR(i, M - 1, N) FOR(j, 1, l[i]) FOR(s, a[i][j], S) {
        c[i][j][s] += c[i + 1][j][ s - a[i][j] ];
        c[i][j][s] += c[i + 1][j + 1][ s - a[i][j] ];
    }

    // Upper triangle
    LFOR(i, N - 1, 1) FOR(j, 1, l[i]) FOR(s, a[i][j], S) {
        c[i][j][s] += c[i + 1][j - 1][ s - a[i][j] ];
        c[i][j][s] += c[i + 1][j][ s - a[i][j] ];
    }

    long long res = 0;
    FOR(j, 1, N)
        res += c[1][j][S];

    if (res == 0) {
        printf("-1");
        return;
    }
    printf("%lld\n", res);

    int j = 1;
    while (c[1][j][S] == 0) ++j;
    printf("%d ", j - 1);

    // Upper triangle
    FOR(i, 1, N - 1) {
        S -= a[i][j];
        if (c[i + 1][j - 1][S] > 0)
            printf("L"), --j;
        else
            printf("R");
    }

    // Lower triangle
    FOR(i, N, M - 1) {
        S -= a[i][j];
        if (c[i + 1][j][S] > 0)
            printf("L");
        else
            printf("R"), ++j;
    }
}

int main() {
	Enter();
	MinPath();
	SPath();
}
