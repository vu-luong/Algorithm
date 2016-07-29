#include <iostream>
using namespace std;

const int f[] = { 0, 1, 2, 6, 24, 120, 720,
                  5040, 40320, 362880, 3628800 };

int a[15];
int n, k, m, res;

void Update() {
    int t = 0;
    for (int i = 1; i <= m; i++)
        t += (a[i] * (a[i] - 1)) / 2;
    if (t != k) return;

    int s = f[n];
    for (int i = 1; i <= m; i++)
        s /= f[a[i]];
    res += s;
}

void Try(int sum, int cnt) {
    if (cnt == 1 && sum > 0) {
        a[1] = sum;
        Update();
        return;
    }
    for (int i = 1; i <= sum - cnt + 1; i++) {
        a[cnt] = i;
        Try(sum - i, cnt - 1);
    }
}

int main() {
    while (scanf("%d", &n)) {
        if (n == -1) break;
        scanf("%d", &k);

        res = 0;
        for (m = 1; m <= n; m++) Try(n, m);
        printf("%d\n", res);
    }
}
