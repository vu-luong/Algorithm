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

const int MAXN = (int) 1e5 + 5;
int n, l, r, ql, qr;
int w[MAXN];
int s1[MAXN], s2[MAXN];
int main() {
    //freopen("354A.txt", "r", stdin);

    cin >> n >> l >> r >> ql >> qr;

    s1[0] = 0;
    for (int i = 1; i <= n; i++) {
        cin >> w[i];
        s1[i] = s1[i - 1] + w[i];
    }

    s1[n + 1] = 0;
    for (int i = n; i >= 1; i--) {
        s2[i] = s2[i + 1] + w[i];
    }

    int res = INT_MAX;
 
    for (int i = 0; i <= n; i++) {
        int t = n - i;

        if (i < t) {
            int s = s1[i]*l;
            int p = s2[i + 1]*r + (t - i - 1)*qr;
            res = min(res, s + p);
        } else {
            if (i > t) {
                int s = s1[i]*l + (i - t - 1)*ql;
                int p = s2[i + 1]*r;
                res = min(res, s + p);
            } else {
                res = min(res, s1[i]*l + s2[i + 1]*r);
            }
        }
    }

    cout << res << endl;
    
}
