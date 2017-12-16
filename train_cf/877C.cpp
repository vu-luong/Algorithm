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
int n;
int main() {
//    freopen("877C.txt", "r", stdin);

    cin >> n;

    if (n == 2) {
        cout << 3 << endl;
        cout << "2 1 2" << endl;
        return 0;
    }

    if (n == 3) {
        cout << 4 << endl;
        cout << "2 1 3 2" << endl;
        return 0;
    }

    int res = 4;
    for (int i = 4; i <= n; i++) {
        if (i % 2 == 0) {
            res += 2;
        } else {
            res += 1;
        }
    }

    cout << res << endl;

    for (int i = 1; i <= n; i++) {
        if (i % 2 == 0) {
            cout << i << " ";
        }
    }

    for (int i = 1; i <= n; i++) {
        if (i % 2 == 1) {
            cout << i << " ";
        }
    }

    for (int i = 1; i <= n; i++) {
        if (i % 2 == 0) {
            cout << i << " ";
        }
    }

}
