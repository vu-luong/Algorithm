#include <iostream>
#include <cstdio>
using namespace std;

const int MAXN = (int)2e6;
const int BASE = (int)1e9;

int f[MAXN], n, k;

int main() {
    cin >> n >> k;
    f[0] = 1;
    for (int i = 1; i <= k; i++)
        f[i] = (f[i - 1] * 2) % BASE;

    f[k + 1] = ((f[k] * 2) % BASE + BASE - f[1]) % BASE;
    for (int i = k + 2; i <= n; i++)
        f[i] = ((f[i - 1] * 2) % BASE + BASE - f[i - k - 1]) % BASE;

    cout << f[n];
}
