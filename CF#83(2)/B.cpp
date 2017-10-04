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
const int MAXN = (int) 1e5 + 5;
int n;
int a[MAXN];


int main() {
    // freopen("B.txt", "r", stdin);

    scanf("%d", &n);
    for (int i = 1; i <= n; i++) {
        scanf("%d", &a[i]);
    }

    sort(a + 1, a + n + 1);

    for (int i = 2; i <= n; i++) {
        if (a[i] == a[i - 1]) continue;
        if (a[i] < a[i - 1] * 2) {
            cout << "YES" << endl;
            return 0;
        }
    }

    cout << "NO" << endl;

}
