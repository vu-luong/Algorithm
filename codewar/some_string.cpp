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

int long long f[10000005];
int n, x, y;

int main() {
//    freopen("some_string.txt", "r", stdin);
    cin >> n >> x >> y;

    f[0] = 0;

    for (int i = 1; i <= n; i++) {
        f[i] = min(f[i - 1] + x, f[(i + 1)/2] + y + (i % 2)*x);
    }

    cout << f[n] << endl;

}
