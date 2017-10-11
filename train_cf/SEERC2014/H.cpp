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

int m, n;

int main() {
    freopen("h.in", "r", stdin);
    cin >> m;
    cin >> n;
    
    int res = 0;

    for (int x = 1; x <= m; x++) {
        for (int y = x; y <= m; y++) {
            int t = x*x + y*y;
            for (int z = y; z <= m; z++) {
                if (t == z*z) res++;
            }
        }
    }

    res += (n - 1)*(m + 1);

    cout << res;

}
