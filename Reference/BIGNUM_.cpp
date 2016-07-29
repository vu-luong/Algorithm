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

#define PB push_back
#define MP make_pair
#define SZ(a) a.size()
#define DEBUG(x) cout << #x << " = " << x << endl;

#define PR(A,n)  { cout << #A << " = "; for (int i = 1, _n = (n); i <= _n; i++) \
                    cout << A[i] << ' '; cout << endl; }
#define PR0(A,n) { cout << #A << " = "; for (int i = 0, _n = (n); i < _n; i++) \
                    cout << A[i] << ' '; cout << endl; }

using namespace std;

typedef vector<long long> BigInt;
const int BASE = 10000;
const int DIGIT = 4;

void fix(BigInt &a) {
    a.push_back(0);

    for (int i = 0; i < a.size() - 1; i++) {
        a[i + 1] += a[i] / BASE;
        a[i] %= BASE;
        if (a[i] < 0) {
            a[i] += BASE;
            a[i + 1]--;
        }
    }

    while (a.size() >= 2 && a.back() == 0)
        a.pop_back();
}

void operator += (BigInt &a, const BigInt &b) {
    a.resize(max(a.size(), b.size()));

    for (int i = 0; i < b.size(); i++) {
        a[i] += b[i];
    }

    fix(a);
}

BigInt operator * (const BigInt &a, const BigInt &b) {

    BigInt c(a.size() + b.size());
    for (int i = 0; i < a.size(); i++) {
        for (int j = 0; j < b.size(); j++) {
            c[i + j] = a[i] * b[j];
        }
    }

    return fix(c), c;
}

BigInt to_BigInt(int x) { // x < BASE
    return BigInt(1, x);
}

void operator -= (BigInt &a, const BigInt &b) {
    for (int i = 0; i < b.size(); i++) {
        a[i] -= b[i];
    }
    fix(a);
}

void operator *= (BigInt &a, int x) { //x < BASE
    for (int i = 0; i < a.size(); i++) {
        a[i] *= x;
    }
    fix(a);
}

BigInt operator + (BigInt a, const BigInt &b) {
    a += b;
    return a;
}

BigInt operator - (BigInt a, const BigInt &b) {
    a -= b;
    return a;
}

BigInt operator * (BigInt a, int x) { // x < BASE
    a *= x;
    return a;
}

bool operator < (const BigInt &a, const BigInt &b) {
    if (a.size() != b.size()) return a.size() < b.size();
    for (int i = a.size() - 1; i >= 0; i--) {
        if (a[i] != b[i])
            return a[i] < b[i];
    }
    return false;
}

void devide(const BigInt &a, int x, BigInt &q, int &r) {
    q.clear();
    r = 0;
    for (int i = a.size() - 1; i >= 0; i--) {
        r = r * BASE + a[i];
        q.push_back(r / x);
        r %= x;
    }
    reverse(q.begin(), q.end());
    fix(q);
}

BigInt operator / (const BigInt &a, int x) {
    BigInt q;
    int r;
    devide(a, x, q, r);
    return q;
}

int operator % (const BigInt &a, int x) {
    BigInt q;
    int r;
    devide(a, x, q, r);
    return r;
}

istream& operator >> (istream& cin, BigInt &a) {
    string s;
    cin >> s;

    a.clear();
    a.resize(s.size() / DIGIT + 1);
    for (int i = 0; i < s.size(); i++) {
        int x = (s.size() - 1 - i) / DIGIT; // <- log10(BASE) = 4;
        a[x] = a[x] * 10 + (s[i] - '0');
    }

    return fix(a), cin;
}

ostream& operator << (ostream& cout, const BigInt &a) {
    printf("%lld", a.back());
    for (int i = (int)a.size() - 2; i >= 0; i--) {
        printf("%04lld", a[i]);
    }
    return cout;
}

int main() {
    freopen("BIGNUM.txt", "r", stdin);

    BigInt a;
    BigInt b;
    cin >> a;
    cin >> b;

    cout << a + b << endl;
    if (a < b) cout << "-" << b - a << endl;
    else cout << a - b << endl;
    cout << a * b << endl;

}
