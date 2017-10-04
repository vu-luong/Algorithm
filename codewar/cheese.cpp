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
const int MAXN = 400005;
int n;

int h[MAXN], l[MAXN], f[MAXN], w[MAXN];
long long s;

int main() {
//    freopen("cheese.txt", "r", stdin);
    
    scanf("%d", &n);

    f[0] = -1;
    l[n + 1] = -1;

    s = 0;

    for (int i = 1; i <= n; i++) {
        scanf("%d %d", &w[i], &h[i]);
            
        if (h[i] > f[i - 1]) {
            f[i] = h[i];
        } else {
            f[i] = f[i - 1];
        }

        s = s + w[i];
    }

    for (int i = n; i >= 1; i--) {
        if (h[i] > l[i + 1]) {
            l[i] = h[i];
        } else {
            l[i] = l[i + 1];
        }
    }

    for (int i = 1; i <= n; i++) {
        
        long long res = 0;
        res = 1ll*(s - w[i]) * max(f[i - 1], l[i + 1]);
        
        if (i != n)
            printf("%lld ", res);
        else 
            printf("%lld\n", res);
    }
}
