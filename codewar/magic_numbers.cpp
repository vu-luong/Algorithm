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
typedef long long LL;
bool isPrime(const int x) {
    if (x <= 1) return false;
    for (int i = 2; i * i <= x; ++i) 
        if (x % i == 0) 
            return false;
    return true;
}
int pow(int x, int e, const int MOD) {
    int r = 1;
    for (; e; e >>= 1,x=(LL)x * x % MOD) 
        if (e & 1) r = (LL)r * x % MOD;
    return r;
}
bool isr(int n, int p) {
    for (int i = 2, q = p - 1; i * i <= q; ++i) {
        if (q % i==0) {
            if (pow(n,i,p) == 1 || pow(n, q / i, p) == 1) return false;
        }   
    }
    return true;
}
int main() {
    int n, x;
    cin >> n >> x;
    if (!isPrime(n + 1)) {
        cout << -1 << endl; 
        return 0;
    }
    for (--x; x > 1; --x) 
        if (isr(x, n + 1)) {
            cout << x <<endl; 
            return 0;
        }
    cout << -1 <<endl; 
    return 0;
}
