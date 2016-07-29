#include <iostream>
#include <cmath>
#include <cstring>
using namespace std;

int c[32][32], t[32];
int x, y, k, b;

int F(int n, int k, int b) {
    int d = 1 + int(log(n) / log(b)), i = d, res = 0;
    memset(t, 0, sizeof(t));
    while (n) t[--i] = n % b, n /= b;
    for (i = 0; i < d; i++) {
        if (k < 0) break;
        if (k == 0) { ++res; break; }
        if (t[i] == 0) continue;
        if (t[i] == 1) res += c[d - i - 1][k--];
        else { res += c[d - i][k]; break; }
    }
    return res;
}

int main() {
    for (int i = 0; i < 32; i++)
        c[i][i] = c[i][0] = 1;
    for (int i = 1; i < 32; i++)
        for (int j = 1; j < i; j++)
            c[i][j] = c[i - 1][j] + c[i - 1][j - 1];

    scanf("%d %d %d %d", &x, &y, &k, &b);
    printf("%d", F(y, k, b) - F(x - 1, k, b));
}
