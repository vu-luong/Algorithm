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

int n, m, x, y, z, p;
int u[MAXN], v[MAXN];

int main() {
    // freopen("C.txt", "r", stdin);

    scanf("%d %d %d %d %d %d", &n, &m, &x, &y, &z, &p);

    for (int i = 1; i <= p; i++) {
        scanf("%d %d", &u[i], &v[i]);
    }

    x = x % 4;
    y = y % 2;
    z = z % 4;
    
    // DEBUG(x);
    // DEBUG(y);
    // DEBUG(z);

    while (x--) {
        for (int i = 1; i <= p; i++) {
            int t1 = v[i];
            int t2 = n - u[i] + 1;

            u[i] = t1;
            v[i] = t2;
        }
        int t = m;
        m = n;
        n = t;
    }

    while (y--) {
        for (int i = 1; i <= p; i++) {
            int t1 = u[i];
            int t2 = m - v[i] + 1;

            u[i] = t1;
            v[i] = t2;
        }
    }

    while (z--) {
        for (int i = 1; i <= p; i++) {
            int t1 = m - v[i] + 1;
            int t2 = u[i];

            u[i] = t1;
            v[i] = t2;
        }
        int t = m;
        m = n;
        n = t;
    }

    for (int i = 1; i <= p; i++) {
        printf("%d %d\n", u[i], v[i]);
    }

}
