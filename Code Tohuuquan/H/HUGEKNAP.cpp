#include <iostream>
#include <vector>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

const int MAXN = 10005, MAXM = 1005;

int w[MAXN], v[MAXN], f[MAXN][MAXM];
int T, n, m;

int main() {
    scanf("%d", &T);
    while (T--) {
        scanf("%d %d", &n, &m);
        FOR(i, 1, n) scanf("%d", w + i);
        FOR(i, 1, n) scanf("%d", v + i);

        FOR(i, 1, n) FOR(j, 1, m) {
            f[i][j] = f[i - 1][j];
            if (w[i] <= j && f[i][j] < f[i - 1][j - w[i]] + v[i])
                f[i][j] = f[i - 1][j - w[i]] + v[i];
        }

        vector <int> a;
        int i = n, j = m;
        while (i) {
            if (f[i][j] != f[i - 1][j]) {
                a.insert(a.begin(), i);
                j -= w[i];
            }
            --i;
        }

        printf("%d %d\n", f[n][m], a.size());
        for (int i = 0; i < a.size(); i++) printf("%d ", a[i]);
        printf("\n");
    }
}
