#include <iostream>
#include <cstring>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

const int MAXN = 35;

int s[MAXN][MAXN][MAXN], v[MAXN][MAXN][MAXN];
int n, nTests;

int Cal(int l, int i, int x, int y) {
    return v[i][x][y] - v[i][x][y - l]
        - (v[i][x - l][y] - v[i][x - l][y - l])
        - (v[i - l][x][y] + v[i - l][x - l][y - l]
           - v[i - l][x - l][y] - v[i - l][x][y - l]);
}

int main() {
    scanf("%d", &nTests);
    while (nTests--) {
        scanf("%d", &n);

        FOR(i, 1, n) FOR(x, 1, n) FOR(y, 1, n) {
            int t; scanf("%d", &t);
            s[i][x][y] = s[i][x][y - 1] + s[i][x - 1][y]
                       + t - s[i][x - 1][y - 1];
        }

        FOR(i, 1, n) FOR(x, 1, n) FOR(y, 1, n)
            v[i][x][y] = v[i - 1][x][y] + s[i][x][y];

        int res = v[n][n][n];
        FOR(l, 1, n) FOR(i, l, n)
            FOR(x, l, n) FOR(y, l, n)
                res = max(res, Cal(l, i, x, y));

        printf("%d\n", res);
    }
}
