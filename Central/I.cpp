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
const int MAXN = 300005;
int n;
int a[MAXN];
long long f[MAXN][5];

int main() {
    //freopen("I.txt", "r", stdin);
 
    cin >> n;

    for (int i = 1; i <= n; i++) {
        cin >> a[i];
    }
    
    long long res = - (long long) 1e16;
    f[0][0] = 0;
    f[0][1] = res;
    f[0][2] = res;
    for (int i = 1; i <= n; i++) {
        f[i][0] = f[i - 1][2] + a[i];
        f[i][2] = f[i - 1][1] + a[i];
        f[i][1] = max(f[i - 1][0], 0ll) + a[i];
        res = max(res, f[i][0]);

    }

    cout << res << endl;



}
