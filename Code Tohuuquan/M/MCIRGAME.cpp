#include <iostream>
#include <vector>
using namespace std;

const int radix = 10000;

typedef vector <int> BigInt;

 BigInt operator * (const BigInt &a, const int x) {
    BigInt b;
    int carry = 0;
    for (int i = 0; i < a.size(); i++) {
        carry += a[i] * x;
        b.push_back(carry % radix);
        carry /= radix;
    }
    if (carry) b.push_back(carry);
    return b;
}

BigInt operator / (const BigInt &a, const int x) {
    BigInt b;
    int hold = 0;
    for (int i = a.size() - 1; i >= 0; i--) {
        hold = hold * radix + a[i];
        b.insert(b.begin(), hold / x);
        hold %= x;
    }
    while (b.back() == 0) b.pop_back();
    return b;
}

BigInt res;
int n;

void Solve() {
    res.clear(); res.push_back(1);
    for (int i = n + 2; i <= n * 2; i++) res = res * i;
    for (int i = 2; i <= n; i++) res = res / i;
}

void Print() {
    int l = res.size();
    printf("%d", res[l - 1]);
    for (int i = l - 2; i >= 0; i--)
        printf("%04d", res[i]);
    printf("\n");
}

int main() {
    while (true) {
        scanf("%d", &n);
        if (n == -1) break;
        Solve();
        Print();
    }
}
