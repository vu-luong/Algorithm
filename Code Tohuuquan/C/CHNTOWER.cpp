#include <iostream>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

typedef long long int64;

const int MAXN = 64, MAXM = 64 - 2;
const int64 radix = (int64)1e12;

struct BigInt {
    int64 lo, hi;

    BigInt() {}
    BigInt(int64 x) { lo = x; hi = 0; }

    friend BigInt operator + (BigInt a, BigInt b) {
        BigInt res;
        res.lo = a.lo + b.lo;
        res.hi = a.hi + b.hi;
        if (res.lo >= radix) res.lo -= radix, ++res.hi;
        return res;
    }

    friend bool operator > (BigInt a, BigInt b) {
        if (a.hi != b.hi) return a.hi > b.hi;
        return a.lo > b.lo;
    }

    void Print() {
        if (hi > 0) printf("%lld%012lld\n", hi, lo);
        else printf("%lld\n", lo);
    }
};

BigInt f[MAXN + 1][MAXM + 1];
int n, m;

int main() {
    FOR(j, 1, MAXM) f[1][j] = 1;
    FOR(i, 2, MAXN) {
        f[i][1] = 1;
        FOR(k, 1, i) f[i][1] = f[i][1] + f[i][1];
        f[i][1].lo -= 1;
        if (f[i][1].lo < 0) f[i][1].lo += radix, --f[i][1].hi;
        FOR(j, 2, MAXM) f[i][j] = f[i][1];
    }

    FOR(i, 2, MAXN) FOR(j, 2, MAXM) FOR(k, 1, i - 1) {
        BigInt t;
        t = f[k][j] + f[k][j] + f[i - k][j - 1];
        if (f[i][j] > t) f[i][j] = t;
    }

    while (scanf("%d %d", &n, &m) != EOF) f[n][m - 2].Print();
}
