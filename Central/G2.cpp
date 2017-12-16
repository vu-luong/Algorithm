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

bool rhas[200], chas[200];
int n, m;
int a[200][200];
int res[200][200];

int main() {
    freopen("G2.txt", "r", stdin);
    cin >> n >> m;
    for (int i = 1; i <= n; i++) {
        string s;
        cin >> s;
        for (int j = 1; j <= m; j++) {
            a[i][j] = (s[j - 1] == '#');
//            DEBUG(a[i][j]);
        }
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            if (a[i][j]) {
                rhas[i] = true;
                chas[j] = true;
            }

            if (rhas[i] && chas[j]) {
                res[i][j] = min(res[i - 1][j], res[i][j - 1]) + 1;
            } else {
                if (rhas[i]) {
                    res[i][j] = res[i][j - 1];
                } else if (chas[j]) {
                    res[i][j] = res[i - 1][j];
                } else {
                    res[i][j] = res[i - 1][j - 1];
                }
            }
        }
    }

    cout << res[n][m];
}
