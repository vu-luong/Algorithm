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

const int MAXN = 5e5 + 10;
int n;
int a[MAXN];
int main() {
    //freopen("372A.txt", "r", stdin);
 
    cin >> n;

    for (int i = 1; i <= n; i++) {
        cin >> a[i];
    }

    sort(a + 1, a + n + 1);

    int pt = (n + 1)/2;

    int res = n;
    for (int i = 1; i <= n/2; i++) {
        int value = a[i] * 2;
        
        while (true) {
            if (a[pt] >= value) {
                res--;
                pt++;
                break;
            } else {
                pt++;
            }
            if (pt == n + 1) break;
        }

        if (pt == n + 1) break;
    }
    

    cout << res << endl;
}
