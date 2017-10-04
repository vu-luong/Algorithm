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

const int MAXN = 111;
const long long BASE = (long long) 1e9 + 7;

int Test;
int p[10];
long long c[MAXN][MAXN];
int a[MAXN];

int main() {
//    freopen("A.txt", "r", stdin);
    
    cin >> Test;

    memset(c, 0, sizeof(c));
    c[0][0] = 1;

    for (int n = 1; n <= 100; n++) {
        c[0][n] = 1;
        for (int k = 1; k <= n; k++) {
            c[k][n] = (c[k - 1][n - 1] + c[k][n - 1]) % BASE;
        }
    }

//    DEBUG(c[5][9]);

    int m = 0;

    while (Test--) {

        for (int i = 1; i <= 9; i++) {
            cin >> p[i];

            while (p[i] -- ) {
                m++;
                a[m] = i;
            }
        }
    
        long long res = a[1];
        l[1] = 1;
        for (int i = 2; i <= m; i++) {
            for (int j = 1; j <= i - 1; j++) {
            }
        }
    }

}
