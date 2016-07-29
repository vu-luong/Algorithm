#include <iostream>
#include <vector>
#include <algorithm>
#include <cstdio>
using namespace std;

typedef long long int64;
typedef vector <int64> BigInt;

const int64 radix = (int64)1e17;

BigInt operator + (const BigInt &a, const BigInt &b) {
    BigInt s;
    int64 carry = 0;
    int l = min(a.size(), b.size());
    for (int i = 0; i < l; i++) {
        carry += a[i] + b[i];
        s.push_back(carry % radix);
        carry /= radix;
    }
    if (l == a.size())
        for (int i = l; i < b.size(); i++) {
            carry += b[i];
            s.push_back(carry % radix);
            carry /= radix;
        }
    else
        for (int i = l; i < a.size(); i++) {
            carry += a[i];
            s.push_back(carry % radix);
            carry /= radix;
        }
    if (carry > 0) s.push_back(carry);
    return s;
}

BigInt operator * (const BigInt &a, const int x) {
    BigInt b;
    int64 carry = 0;
    for (int i = 0; i < a.size(); i++) {
        carry += a[i] * x;
        b.push_back(carry % radix);
        carry /= radix;
    }
    if (carry > 0) b.push_back(carry);
    return b;
}

const int MAX = 65;

BigInt a[MAX], res;
int T;
int64 n;

void Init() {
    a[0].clear(); a[0].push_back(1);
    for (int i = 1; i < MAX; i++)
        a[i] = a[i - 1] * 3;
}

void Solve() {
    vector <int> b;
    while (n > 0) {
        b.push_back(n % 2);
        n /= 2;
    }
    res.clear(); res.push_back(0);
    for (int i = 0; i < b.size(); i++)
        if (b[i]) res = res + a[i];
}

void Print() {
    int l = res.size();
    printf("%lld", res[l - 1]);
    for (int i = l - 2; i >= 0; i--)
        printf("%017lld", res[i]);
    printf("\n");
}

int main() {
    Init();
    scanf("%d", &T);
    while (T--) {
        scanf("%lld", &n);
        Solve();
        Print();
    }
}
