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
const long long BASE = (long long) 1e9 + 7;
const int MAXN = (int) 1e6 + 10;
int a, b, n;

long long fac[MAXN];
bool check(string s) {
    for (int i = 0; i < s.length(); i++) {
        if (s[i] - '0' != a && s[i] - '0' != b) {
            return false;
        }
    }

    return true;
}

long long POW(long long x, long long m) {
    if (m == 0) return 1;

    long long temp = POW(x, m/2);
    if (m % 2 == 1) {
        return (((temp*temp) % BASE)*x) % BASE;
    } else {
        return (temp * temp) % BASE;
    }
}

long long inv(long long v) {
    return POW(v, BASE - 2);
}

long long cal(int n, int k) {
    return (fac[n] * inv((fac[k] * fac[n - k]) % BASE)) % BASE;
}

int main() {
    //freopen("300C.txt", "r", stdin);
 
    cin >> a >> b >> n;

    fac[0] = 1;
    for (int i = 1; i <= n; i++) {
        fac[i] = (fac[i - 1] * i) % BASE;

    }

    long long t = fac[3] * fac[0];
    
    long long res = 0;

    for (int i = 0; i <= n; i++) {
        int sum = i*a + (n - i)*b;
        
        string s = to_string(sum);
       
        if (check(s)) {
            res = (res + cal(n, i)) % BASE;
        }
    }

    cout << res << endl;

}
