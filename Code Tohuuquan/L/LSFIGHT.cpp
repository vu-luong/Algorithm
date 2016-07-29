#include <cstdio>
#include <vector>
using namespace std;

const int MAXN = 505;

bool a[MAXN][MAXN], f[MAXN][MAXN];
int next[MAXN];
int n;

int main() {
    scanf("%d", &n);
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            scanf("%d", &a[i][j]);

    for (int i = 0; i < n; i++) {
        next[i] = (i + 1) % n;
        f[i][next[i]] = true;
    }

    for (int d = 2; d <= n; d++)
        for (int i = 0; i < n; i++) {
            int j = (i + d) % n;

            for (int k = next[i]; k != i; k = next[k])
                if (f[i][k] && f[k][j] && (a[i][k] || a[j][k])) {
                    f[i][j] = true;
                    break;
                }
        }

    vector <int> res;
    for (int i = 0; i < n; i++)
        if (f[i][i]) res.push_back(i + 1);

    printf("%d\n", res.size());
    for (int i = 0; i < res.size(); i++)
        printf("%d\n", res[i]);
}
