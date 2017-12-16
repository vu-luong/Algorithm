#include <bits/stdc++.h>

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
            a[i + 1]--; }
    }
    while (a.size() >= 2 && a.back() == 0)
        a.pop_back();
}


BigInt to_BigInt(int x) { // x < BASE
    return BigInt(1, x);
}

ostream& operator << (ostream& cout, const BigInt &a) {
    printf("%lld", a.back());
    for (int i = (int)a.size() - 2; i >= 0; i--) {
        printf("%04lld", a[i]);
    }
    return cout;
}

void operator *= (BigInt &a, int x) { //x < BASE
    for (int i = 0; i < a.size(); i++) {
        a[i] *= x; 
    }
    fix(a); 
}

BigInt operator * (const BigInt &a, const BigInt &b) {
    BigInt c(a.size() + b.size());
    for (int i = 0; i < a.size(); i++) {
        for (int j = 0; j < b.size(); j++) {
            c[i + j] += a[i] * b[j];
        }
    }
    fix(c);
    return c;
}

int n;
int f[100];

int main() {
    //freopen("F.txt", "r", stdin);

    cin >> n;

    if (n <= 2) {
        cout << 1 << endl;
        return 0;
    }

    f[1] = 1;
    f[2] = 1;

    for (int i = 3; i <= n; i++) {
        f[i] = f[i - 1] + f[i - 2];
    }

    BigInt a = to_BigInt(1);
    BigInt b = to_BigInt(f[n]);

    for (int i = 1; i <= n; i++) {
        a = a * b;
    }

    cout << a << endl;
}
