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

const int MAXN = (int) 1e5 + 5;
const long long oo = (long long) 1e16;
int n;
int a[MAXN];

int main() {
//    freopen("C.txt", "r", stdin);
    
    scanf("%d", &n);
    for (int i = 1; i <= n; i++) {
        scanf("%d", &a[i]);
    }
    for (int i = 1; i <= n - 1; i++) {
        a[i] = abs(a[i] - a[i + 1]);
    }
    n = n - 1;
    
//    PR(a, n);

    long long s = 0;
    long long min_r = 0;
    long long res = -oo;

    for (int i = 1; i <= n; i++) {
        if (i % 2 == 1) {
            s += a[i];
        } else {
            s -= a[i];
            if (s < 0 && s < min_r) {
                min_r = s;
            }
        }

//        DEBUG(s);

        if (s - min_r > res) {
            res = s - min_r;
        }
    }

    s = 0;
    min_r = 0;
    for (int i = 1; i <= n; i++) {
        if (i % 2 == 0) {
            s += a[i];
        } else {
            s -= a[i];
            if (s < 0 && s < min_r) {
                min_r = s;
            }
        }

//        DEBUG(s);
//        DEBUG(min_r);

        if (s - min_r > res) {
            res = s - min_r;
        }
    }

    for (int i = 1; i <= n; i++) {
        
    }

    cout << res << endl;

}
