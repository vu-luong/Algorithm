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

const int MAXN = 1005;

int n;
int a[MAXN], b[MAXN], c[MAXN];


int main() {
    freopen("STPAR.txt", "r", stdin);
    
    while (true) {
        scanf("%d", &n);
        if (n == 0) break;
        
        for (int i = 1; i <= n; i++) {
            scanf("%d", &a[i]);
        }
        
        int nc = 0;
        int nb = 0;
        int na = 1;
        bool ok = true;
        while (true) {

            if (a[na] == c[nc] + 1) {
                nc++;
                c[nc] = a[na];        
                na++;
            } else 
            if (b[nb] == c[nc] + 1){
                nc++;
                c[nc] = b[nb];
                nb--;
            } else {
                if (na == n + 1) {
                    ok = false;
                    break;
                }
                nb++;
                b[nb] = a[na];
                na++;
            }

            if (nc == n) break;

        }
//        DEBUG(nc);
//        PR(c, nc);
//        DEBUG(nb);
//        PR(b, nb);

        if (ok) cout << "yes" << endl;
        else cout << "no" << endl;

    }


}
