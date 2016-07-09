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

using namespace std;

#define PB push_back
#define MP make_pair
#define SZ(a) a.size()
#define DEBUG(x) cout << #x << " = " << x << endl;

using namespace std;
const int MAXN = 505;
int n, k;
int c[MAXN];
bool f[MAXN][MAXN][MAXN];

int main() {
    // freopen("E.txt", "r", stdin);

    scanf("%d %d", &n, &k);

    for (int i = 1; i <= n; i++) {
        scanf("%d", &c[i]);
    }

    f[0][0][0] = true;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            for (int l = 0; l <= j; l++) {
                bool ok = false;
                if (j >= c[i] && l >= c[i] && f[i - 1][j - c[i]][l - c[i]]) ok = true;
                if (j >= c[i] && f[i - 1][j - c[i]][l]) ok = true;
                if (f[i - 1][j][l]) ok = true;
                f[i][j][l] = ok;
            }
        }
    }

    int res = 0;
    int q[MAXN];

    for (int j = 0; j <= k; j++) {
        for (int i = 1; i <= n; i++) {
            if (f[i][k][j]) {
                res++;
                q[res] = j;
                break;
            }
        }
    }

    cout << res << endl;
    for (int i = 1; i <= res; i++) {
        cout << q[i] << " ";
    }

}
