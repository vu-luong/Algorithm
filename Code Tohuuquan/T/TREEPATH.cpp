#include <iostream>
#include <vector>
using namespace std;

const int MAXN = 2005;
const int BASE = 10000;

typedef vector <int> BigInt;

BigInt t[MAXN], f[MAXN];
string s;
int n;
BigInt res;

BigInt operator * (const BigInt a, const int mul) {
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

BigInt operator + (const BigInt a, const BigInt b) {
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

BigInt operator - (const BigInt a, const BigInt b) {
    BigInt c;
    int carry = 0;
    for (int i = 0; i < a.size(); i++) {
        int s = a[i] - carry;
        if (i < b.size()) s -= b[i];
        if (s < 0) s += BASE, carry = 1;
        else carry = 0;
        c.push_back(s);
    }
    return c;
}

void Print(BigInt a) {
    int L = a.size();
    printf("%d", a[L - 1]);
    for (int i = L - 2; i >= 0; i--)
        printf("%04d", a[i]);
}

int main() {
    getline(cin, s);
    n = s.size();
    s = ' ' + s;

    t[0].push_back(1);
    for (int i = 1; i <= n; i++)
        if (s[i] != '*') t[i] = t[i - 1];
        else t[i] = t[i - 1] * 4;

    res.push_back(1);
    f[0].push_back(1);
    for (int i = 1; i <= n; i++)
        switch (s[i]) {
            case '*' :
                f[i] = (f[i - 1] * 10) + (t[i - 1] * 3);
                res = (res * 4) + (f[i] - f[i - 1]);
                break;

            case 'L' :
                f[i] = f[i - 1] * 3;
                res = res + f[i];
                break;

            case 'S' :
                f[i] = f[i - 1];
                break;

            case 'C' :
                f[i] = (f[i - 1] * 3) + t[i - 1];
                res = res + f[i];
                break;

            case 'R' :
                f[i] = (f[i - 1] * 3) + (t[i - 1] * 2);
                res = res + f[i];
        }

    Print(res);
}
