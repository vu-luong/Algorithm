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

set<int> s;
int n;
int a[200];
int res[200];
int main() {
    freopen("H.txt", "r", stdin);
 
    cin >> n;
    for (int i = 1; i <= n; i++) {
        cin >> a[i];
        s.insert(i);
    }
    next_permutation(a + 1, a + 1 + n);
    PR(a, n);

    bool ok = false;
    for (int i = 1; i <= n; i++) {
        if (s.find(i) == s.end()) { 
            if (res[i] > a[i]) ok = true;
            continue;
        }
        int first = a[i];
        if (ok) first = 1;
        for (int x = first; x <= n; x++) {
            if (s.find(x) != s.end()) {
                if (x == a[i]) {
                    if (i < a[x]) continue;
                }
                res[i] = x;
                res[x] = i;
                s.erase(i);
                s.erase(x);


                if (x > a[i]) {
                    ok = true;
                }
                break;
            }
        }
    }

    for (int i = 1; i <= n; i++) {
        cout << res[i] << " ";
    }

}
