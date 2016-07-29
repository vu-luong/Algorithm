#include <cstdio>
#include <cstring>
#include <algorithm>
using namespace std;

const int MAXN = 100, MAXM = 6;
const int BASE = (int)1e9;

int f[MAXN + 1][1 << (MAXM * 2) + 1], bit[MAXM * 2 + 2];
bool visited[MAXN + 1][1 << (MAXM * 2) + 1];
int n, m;

int Find(int j, int code) {
    code &= bit[1 + m + m] - 1;
    if (visited[j][code]) return f[j][code];
    visited[j][code] = true;

    if (j == n) return f[j][code] = 1;
    int sum = 0;
    for (int i = max(0, m + j - n + 1); i <= min(j + m, m + m); i++)
        if ((code & bit[i]) == 0)
            sum = (sum + Find(j + 1, (code | bit[i]) << 1)) % BASE;
    return f[j][code] = sum;
}

int main() {
    bit[0] = 1;
    for (int i = 1; i < MAXM * 2 + 2; i++)
        bit[i] = bit[i - 1] << 1;

    while (scanf("%d %d", &n, &m) != EOF) {
        memset(visited, false, sizeof(visited));
        printf("%d\n", Find(0, 0));
    }
}
