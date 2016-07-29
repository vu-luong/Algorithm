#include <cstdio>
#include <vector>
using namespace std;

const int BASE = 10000;
const int MAXN = 1001;

typedef vector <int> BigInt;

BigInt operator + (BigInt a, BigInt b) {
    BigInt c;
    int carry = 0;
    for (int i = 0; i < a.size() || i < b.size(); i++) {
        if (i < a.size()) carry += a[i];
        if (i < b.size()) carry += b[i];
        c.push_back(carry % BASE);
        carry /= BASE;
    }
    if (carry) c.push_back(carry);

    return c;
}

BigInt operator * (BigInt a, BigInt b) {
    BigInt c(a.size() + b.size() + 2, 0);
    for (int i = 0; i < a.size(); i++) {
        int carry = 0;
        for (int j = 0; j < b.size(); j++) {
            int k = i + j;
            c[k] += a[i] * b[j] + carry;
            carry = c[k] / BASE;
            c[k] %= BASE;
        }
        if (carry) c[i + b.size()] += carry;
    }
    while (*c.rbegin() == 0 && c.size() > 0)
        c.erase(c.begin() + c.size() - 1);

    return c;
}

BigInt operator * (BigInt a, int mul) {
    BigInt c;
    int carry = 0;
    for (int i = 0; i < a.size(); i++) {
        carry += a[i] * mul;
        c.push_back(carry % BASE);
        carry /= BASE;
    }
    if (carry) c.push_back(carry);

    return c;
}

void Print(BigInt a) {
    int L = a.size();
    printf("%d", a[L - 1]);
    for (int i = L - 2; i >= 0; i--)
        printf("%04d", a[i]);
    printf("\n");
}

BigInt f[MAXN];
int n;

int main() {
    f[1].push_back(1);
    f[2].push_back(2);
    for (int i = 3; i < MAXN; i++)
        f[i] = f[i - 1] + f[i - 2];

    while (scanf("%d", &n) != EOF) {
        BigInt res(1, 2);
        res = res + (f[n] * f[n - 1] * f[n - 1] * f[n - 2]) * 12;
        res = res + (f[n - 1] * f[n - 1] * f[n - 1] * f[n - 1]) * 2;
        res = res + (f[n] * f[n] * f[n - 2] * f[n - 2]) * 2;

        Print(res);
    }
}
