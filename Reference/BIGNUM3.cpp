#include <map>
#include <set>
#include <cmath>
#include <cstdio>
#include <vector>
#include <string>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <algorithm>
#include <string>

#define PB push_back
#define MP make_pair
#define SZ(a) a.size()
#define DEBUG(x) cout << #x << " = " << x << endl;

#define PR(A,n)  { cout << #A << " = "; for (int i = 1, _n = (n); i <= _n; i++) \
                    cout << A[i] << ' '; cout << endl; }
#define PR0(A,n) { cout << #A << " = "; for (int i = 0, _n = (n); i < _n; i++) \
                    cout << A[i] << ' '; cout << endl; }

using namespace std;

const int MAXN = 301;
const int DIGIT = 4;
const int BASE = 10000;

typedef vector<long long> BigInt;

BigInt to_BigInt(string s) {
    int sn = (s.length() + DIGIT - 1) / DIGIT;
    BigInt a(sn + 1);
    while (s.length() < sn * DIGIT)
        s = '0' + s;

    int j = s.length() - 1;
    a[0] = sn;

    for (int i = 1; i <= sn; i++) {
        string m = s.substr(j - DIGIT + 1, DIGIT);
        j = j - DIGIT;
        a[i] = stoi(m);
        // cout << m << endl;
    }

    return a;

}
void out(const BigInt &a) {
    string res = "";
    for (int i = 1; i <= a[0]; i++) {
        string s = to_string(a[i]);
        while (s.length() < DIGIT) {
            s = '0' + s;
        }
        res = s + res;
    }
    while (res[0] == '0' && res.length() > 1) {
        res.erase(0, 1);
    }
    cout << res << endl;
    // cout << res.length() << endl;
}

BigInt operator + (BigInt &a, BigInt &b) {

    BigInt sum(max(a[0], b[0]) + 1);
    sum[0] = max(a[0], b[0]);
    a.resize(sum[0] + 1);
    b.resize(sum[0] + 1);

    long long r = 0;
    for (int i = 1; i <= sum[0]; i++) {
        int num = a[i] + b[i] + r;
        sum[i] = num % BASE;
        r = num / BASE;
    }
    // DEBUG(sum[0]);
    if (r > 0) {
        sum[0]++;
        sum.push_back(r);
    }

    return sum;
}

BigInt operator - (BigInt &a, BigInt &b) {

    BigInt minus(max(a[0], b[0]) + 1);
    minus[0] =  max(a[0], b[0]);
    a.resize(minus[0] + 1);
    b.resize(minus[0] + 1);

    long long r = 0;
    for (int i = 1; i <= minus[0]; i++) {
        int num = a[i] - b[i] - r;
        if (num < 0) {
            r = 1;
            num = num + BASE;
        } else r = 0;
        minus[i] = num % BASE;
    }

    return minus;
}

BigInt operator * (const BigInt &a, const BigInt &b) {

    BigInt mul(a[0] + b[0]);
    fill(mul.begin(), mul.end(), 0);

    mul[0] = a[0] + b[0] - 1;
    // DEBUG(mul[0]);

    for (int i = 1; i <= a[0]; i++) {
        for (int j = 1; j <= b[0]; j++) {
            mul[i + j - 1] = mul[i + j - 1] + a[i] * b[j];
        }
    }

    long long r = 0;
    for (int i = 1; i <= mul[0]; i++) {
        long long x = mul[i] + r;
        r = x / BASE;
        mul[i] = x % BASE;
    }
    // DEBUG(r);

    if (r > 0) {
        mul[0] ++;
        mul.push_back(r);
    }

    return mul;
}
string s1, s2;
int main() {
    freopen("BIGNUM.txt", "r", stdin);
    cin >> s1 >> s2;

    BigInt a1 = to_BigInt(s1);
    BigInt a2 = to_BigInt(s2);
    //
    // out(a1);
    // out(a2);

    BigInt sum = a1 + a2;
    out(sum);

    if (s1 == s2) cout << 0 << endl;
    else {
        if (s1.length() < s2.length() || (s1.length() == s2.length() && s1 < s2)) {
            cout << "-";
            out(a2 - a1);
        } else out(a1 - a2);
    }

    out(a1 * a2);
}
