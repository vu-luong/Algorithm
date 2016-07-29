#include <iostream>
#include <vector>
using namespace std;

const int MAXN = 1010, MAXM = MAXN / 2;
const int radix = 10000;

typedef vector <int> BigInt;

BigInt operator + (const BigInt a, BigInt b) {
    BigInt res;
    int carry = 0;
    for (int i = 0; i < a.size() || i < b.size(); i++) {
        if (i < a.size()) carry += a[i];
        if (i < b.size()) carry += b[i];
        res.push_back(carry % radix);
        carry /= radix;
    }
    if (carry) res.push_back(carry);
    return res;
}

void Print(const BigInt d) {
    printf("%d", d[d.size() - 1]);
    for (int i = d.size() - 2; i >= 0; i--)
        printf("%04d", d[i]);
}

BigInt c[MAXM];
int n, m;

int main() {
    scanf("%d %d", &n, &m);
    int k = 0;
    for (int i = 0; i < m; i++) {
        int x; scanf("%d", &x);
        k += x;
    }
    n = n - k + 1;
    if (n < m) { printf("0"); return 0; }

    c[0].push_back(1);
    for (int i = 1; i <= n; i++)
        for (int j = min(i, m); j > 0; j--)
            c[j] = c[j] + c[j - 1];

    Print(c[m]);
}
