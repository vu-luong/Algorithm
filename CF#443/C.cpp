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
const int MAXN = (int) 5e5 + 55;

int a[MAXN];
char c[MAXN];
int s[MAXN];
int n;

int main() {
//    freopen("C.txt", "r", stdin);
    
    cin >> n;
    for (int i = 1; i <= n; i++) {
        cin >> c[i] >> a[i];
    }
    
    int res1 = 2047;
    int res2 = 0;
    int res3 = 0;
    for (int i = 1; i <= n; i++) {
        if (c[i] == '&') res1 = res1 & a[i];
        if (c[i] == '^') res2 = res2 ^ a[i];
        if (c[i] == '|') res3 = res3 | a[i];
    }

    int ans = 0;
    bool ok1 = false, ok2= false, ok3= false;

    for (int i = 1; i <= n; i++) {
        if (c[i] == '|' && !ok1) {
            ok1 = true;
            ans++;
        }

        if (c[i] == '^' && !ok2) {
            ok2 = true;
            ans++;
        }

        if (c[i] == '&' && !ok3) {
            ok3 = true;
            ans++;
        }

        if (ok1 && ok2 && ok3) break;
    }

    cout << ans << endl;
    ok1 = false;
    ok2 = false;
    ok3 = false;
    for (int i = 1; i <= n; i++) {
        if (c[i] == '|' && !ok1) {
            cout << "| " << res3 << endl; 
            ok1 = true;
            ans++;
        }

        if (c[i] == '^' && !ok2) {
            ok2 = true;
            cout << "^ " << res2 << endl;
            ans++;
        }

        if (c[i] == '&' && !ok3) {
            ok3 = true;
            cout << "& " << res1 << endl;
            ans++;
        }
        if (ok1 && ok2 && ok3) break;
    }
}
