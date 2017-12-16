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
long long n;
int main() {
//    freopen("235A.txt", "r", stdin);
 
    cin >> n;

    if (n == 1) cout << 1 << endl;
    else if (n == 2) cout << 2 << endl;
    else if (n == 3) cout << 6 << endl;
    else {
        if (n % 2 == 1) cout << n*(n - 1)*(n - 2) << endl;
        else {
            if (n % 3 != 0) {
                cout << n * (n - 1) * (n - 3) << endl;
            } else {
                cout << (n - 1)*(n - 2)*(n - 3) << endl;
            }
        }
    }

}
