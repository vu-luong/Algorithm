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

string s;
int a[1005];
int m;
bool ok;
int f[1005][15][15];

void dfs(int k, int dif, int pre) {
    if (ok) return;
    if (k > m) {
        cout << "YES" << endl;
        for (int i = 1; i <= m; i++) {
            cout << a[i] << " ";
        }
        ok = true;
        return;
    }

    if (f[k][dif][pre] != 0) return;

    for (int i = dif + 1; i <= 10; i++) {
        if (s[i - 1] == '1' && i != pre) {
            a[k] = i;
            f[k][dif][pre] = 1;
            dfs(k + 1, i - dif, i);
        }
    }
}

int main() {
    //freopen("339C.txt", "r", stdin);
 
    cin >> s;
    cin >> m;

    ok = false;
    dfs(1, 0, 0);

    if (!ok) cout << "NO" << endl;

}
