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
const int MAXN = 10005;
int n;
int a[MAXN], b[MAXN];

int main() {
    // freopen("F.txt", "r", stdin);

    scanf("%d", &n);

    for (int i = 1; i <= n - 1; i++) {
        scanf("%d %d", &a[i], &b[i]);
    }

    int res = 0;

    for (int i = 1; i <= n - 2; i++) {
        for (int j = i + 1; j <= n - 1; j++) {
            if (a[i] == a[j] || a[i] == b[j]
                || b[i] == a[j] || b[i] == b[j]) {
                    res += 1;
                }
        }
    }

    cout << res << endl;

}
