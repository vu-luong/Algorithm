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
const int MAXN = (int) 8e4 + 5;
const int MAXM = (int) 8e3 + 5;

int x[MAXN], y[MAXN], xx[MAXN], yy[MAXN];
int r[MAXN], l[MAXN], r1[MAXN], l1[MAXN];

int n, m, rr;


int main() {
    // freopen("B.txt", "r", stdin);

    scanf("%d %d %d", &n, &m, &rr);
    int nn = 0;
    for (int i = 1; i <= n; i++) {
        int u, v;
        scanf("%d %d", &u, &v);

        if (u*u + v*v <= rr*rr) {
            nn++;
            x[nn] = u;
            y[nn] = v;
        }
    }
    n = nn;

    l[1] = 1;
    r[1] = n;
    int dem = 1;
    int new_d = 1;
    for (int j = 1; j <= m; j++) {
        int aa, bb, cc;
        scanf("%d %d %d", &aa, &bb, &cc);
    //    double kc = abs(cc)*1.0f / sqrt(aa*aa + bb*bb);

        // a[j] = aa;
        // b[j] = bb;
        // c[j] = cc;
        int first, last;
        int cnt = 0;
        for (int k = 1; k <= dem; k++) {
            first = l[k];
            last = r[k];
            int d1 = 0;
            int d2 = 0;
            for (int i = l[k]; i <= r[k]; i++) {
                int val = aa * x[i] + bb*y[i] + cc;
                if (val < 0) {
                    // swap(i, first);
                    xx[first] = x[i];
                    yy[first] = y[i];
                    // DEBUG(first);
                    // DEBUG(k);
                    // DEBUG(l[k]);
                    if (first == l[k]) {
                        cnt++;
                        d1 = cnt;
                        l1[d1] = first;
                    }
                    r1[d1] = first;
                    first++;
                } else {
                    xx[last] = x[i];
                    yy[last] = y[i];
                    // swap(i, last);
                    if (last == r[k]) {
                        cnt++;
                        d2 = cnt;
                        r1[d2] = last;
                    }
                    l1[d2] = last;
                    last--;
                }
            }

            for (int i = l[k]; i <= r[k]; i++) {
                x[i] = xx[i];
                y[i] = yy[i];
            }
        }

        for (int i = 1; i <= cnt; i++) {
            l[i] = l1[i];
            r[i] = r1[i];
        }

        dem = cnt;
    }

    // DEBUG(dem);

    for (int i = new_d; i <= dem; i++) {
        if (r[i] - l[i] + 1 > 1) {
            cout << "YES";
            return 0;
        }
    }

    cout << "NO";

}
