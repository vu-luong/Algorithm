#include <iostream>
#include <cstdio>
#include <vector>
using namespace std;

typedef long long int64;
typedef vector <int64> BigInt;

const int MAXN = 605;
const int64 BASE = (int64)1e18;

BigInt operator * (const BigInt a, const int b) {
    BigInt c;
    int64 cr = 0;
    for (int i = 0; i < a.size(); i++) {
        cr += a[i] * b;
        c.push_back(cr % BASE);
        cr /= BASE;
    }
    if (cr) c.push_back(cr);

    return c;
}

BigInt operator - (const BigInt a, const BigInt b) {
    BigInt c;
    int cr = 0;
    for (int i = 0; i < a.size(); i++) {
        int64 s = a[i] - cr;
        if (i < b.size()) s -= b[i];
        if (s < 0) s += BASE, cr = 1; else cr = 0;
        c.push_back(s);
    }
    while (*c.rbegin() == 0 && c.size() > 1) c.pop_back();

    return c;
}

void Print(const BigInt a) {
    int L = a.size() - 1;
    printf("%lld", a[L]);
    for (int i = L - 1; i >= 0; i--)
        printf("%018lld", a[i]);
}

BigInt f[MAXN];
int n, k;

int main() {
    cin >> n >> k;
    f[0].assign(1, 1);
    for (int i = 1; i <= k; i++)
        f[i] = f[i - 1] * 2;

    f[k + 1] = (f[k] * 2) - f[1];
    for (int i = k + 2; i <= n; i++)
        f[i] = (f[i - 1] * 2) - f[i - k - 1];

    Print(f[n]);
}
