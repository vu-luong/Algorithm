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
const int MAXN = 200;
const int inf = (int)1e9 + 7;
int n;
int a[MAXN];
int f[5][MAXN];
bool sp[MAXN], co[MAXN];

int main() {
    // freopen("C.txt", "r", stdin);

    scanf("%d", &n);

    for (int i = 1; i <= n; i++){
        scanf("%d", &a[i]);
        if (a[i] == 1 || a[i] == 3) co[i] = true;
        if (a[i] == 2 || a[i] == 3) sp[i] = true;
    }

    // f[1][i]: rest
    // f[2][i]: sport
    // f[3][i]: contest
    for (int i = 1; i <= n; i++) {
        f[1][i] = min(min(f[1][i - 1], f[2][i - 1]), f[3][i - 1]) + 1;
        f[2][i] = min(f[1][i - 1], f[3][i - 1]);
        f[3][i] = min(f[1][i - 1], f[2][i - 1]);
        if (!co[i]) f[3][i] = inf;
        if (!sp[i]) f[2][i] = inf;
        // cout << i << " : " << f[1][i] << " " << f[2][i] << " " << f[3][i] << endl;
    }

    cout << min(min(f[1][n], f[2][n]), f[3][n]);


}
