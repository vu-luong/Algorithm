#include <map>
#include <set>
#include <cmath>
#include <cstdio>
#include <vector>
#include <string>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <algorithm>

#define PB push_back
#define MP make_pair
#define SZ(a) a.size()
#define DEBUG(x) cout << #x << " = " << x << endl;

#define PR(A,n)  { cout << #A << " = "; for (int i = 1, _n = (n); i <= _n; i++) \
                    cout << A[i] << ' '; cout << endl; }
#define PR0(A,n) { cout << #A << " = "; for (int i = 0, _n = (n); i < _n; i++) \
                    cout << A[i] << ' '; cout << endl; }

using namespace std;
int n, k;
int a[10000], b[10000];


int main() {
//    freopen("A.txt", "r", stdin);
    
    cin >> n >> k;

    for (int i = 1; i <= n; i++) {
        cin >> a[i];
    }

    for (int i = 1; i <= k; i++) {
        cin >> b[i];
    }

    if (k >= 2) {
        cout << "Yes" << endl;
    } else {
        for (int i = 1; i <= n; i++) {
            if (a[i] == 0) a[i] = b[1];
        }

        for (int i = 1; i <= n - 1; i++) {
            if (a[i + 1] <= a[i]) {
                cout << "Yes" << endl;
                return 0;
            }

        }

        cout << "No" << endl;
    }

}
