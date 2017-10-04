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

const int MAXN = (int) 3e5 + 5;
const long long oo = (long long) 2e18 + 7;
int n, m, k;
long long a[MAXN];
long long f[MAXN], g[MAXN];

int main() {

    cin >> n >> m >> k;
    int pos = 0;
    
    f[0] = 0;
    for (int i = 1; i <= n; i++) {
        scanf("%lld", &a[i]);
        f[i] = f[i - 1] | a[i];
    }
    g[n + 1] = 0;
    for (int i = n; i >= 1; i--) {
        g[i] = g[i + 1] | a[i];
    }
    
    long long res = -1;
    for (int i = 1; i <= n; i++) {
        long long t = a[i];
        for (int j = 1; j <= m; j++) {
            t = t * k;
        }
//        DEBUG(t);
        if ((f[i - 1] | g[i + 1] | t) > res) {
            res = f[i - 1] | g[i + 1] | t;
        } 
    }

//    DEBUG(f[n - 1]);
//    DEBUG(g[n + 1]);

    cout << res << endl;

}
