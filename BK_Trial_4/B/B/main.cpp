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
const int MAXN = (int) 1e4 + 5;
const int MAXM = (int) 1e3 + 5;

int x[MAXN], y[MAXN];
int r[MAXN], l[MAXN];

int n, m, rr;

void swap(int i, int j) {
    int temp = x[i];
    x[i] = x[j];
    x[j] = temp;
    
    temp = y[i];
    y[i] = y[j];
    y[j] = temp;
}

int main() {
    freopen("B.txt", "r", stdin);
    
    scanf("%d %d %d", &n, &m, &rr);
    for (int i = 1; i <= n; i++) {
        scanf("%d %d", &x[i], &y[i]);
        cout << x[i] << " " << y[i] << endl;
    }
    
    l[1] = 1;
    r[1] = n;
    int dem = 1;
    
    for (int j = 1; j <= m; j++) {
        int aa, bb, cc;
        scanf("%d %d %d", &aa, &bb, &cc);
        //        double kc = abs(cc)*1.0f / sqrt(aa*aa + bb*bb);
        // a[j] = aa;
        // b[j] = bb;
        // c[j] = cc;
        int first, last;
        int dd = dem;
        for (int k = 1; k <= dd; k++) {
            int first = l[k];
            int last = r[k];
            int d1 = 0;
            int d2 = 0;
            for (int i = l[k]; i <= r[k]; i++) {
                int val = aa * x[i] + bb*y[i] + cc;
                if (val < 0) {
                    swap(i, first);
                    if (first == l[k]) {
                        d1 = dem++;
                        l[d1] = first;
                    }
                    r[d1] = first;
                    first++;
                } else {
                    swap(i, last);
                    if (last == r[k]) {
                        d2 = dem++;
                        r[d2] = last;
                    }
                    l[d2] = last;
                    last--;
                }
            }
        }
    }
    
    for (int i = 1; i <= dem; i++) {
        if (r[i] - l[i] + 1 > 1) {
            cout << "YES";
            return 0;
        }
    }
    
    cout << "NO";
    
}
