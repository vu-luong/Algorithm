#include <cstdio>
#include <algorithm>
using namespace std;

const int MAXN = 2005;

int a[MAXN], s[MAXN], f[MAXN][MAXN];
int n;

int main() {
    scanf("%d", &n);
    for (int i = 1; i <= n; i++)
        scanf("%d", &a[n - i + 1]);
    for (int i = 1; i <= n; i++)
        s[i] = s[i - 1] + a[i];

    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= n; j++) {
            f[i][j] = f[i][j - 1];

            if (i >= j * 2 - 1)
                f[i][j] = max(f[i][j], s[i] - f[i - (j * 2 - 1)][j * 2 - 1]);

            if (i >= j * 2)
                f[i][j] = max(f[i][j], s[i] - f[i - (j * 2)][j * 2]);
        }

    printf("%d", f[n][1]);
}
