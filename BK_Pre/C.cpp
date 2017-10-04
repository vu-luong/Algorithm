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
const int MAXN = (int) 1e6 + 100;

int n;
int f[MAXN];
int max_s;
pair<int, int> s[MAXN];
pair<int, int> p[MAXN];
// vector<int> a;

int main() {
    // freopen("C.inp", "r", stdin);

    scanf("%d", &n);
    max_s = -1;
    for (int i = 1; i <= n; i++) {
        int u, v;
        scanf("%d %d", &u, &v);
        s[i].first = u;
        s[i].second = v;
        max_s = max(max_s, v);

        p[i].first = v;
        p[i].second = u;
    }

    sort(s + 1, s + n + 1);
    sort(p + 1, p + n + 1);

    int res = 0;

    int jchay = 0;
    int max_j = 0;
    for (int i = 1; i <= n; i++) {
        while (true) {
            if (p[jchay + 1].first >= s[i].first) break;
            jchay++;

            max_j = max(max_j, p[jchay].first - p[jchay].second);
        }

        if (max_j > 0) res = max(res, max_j + s[i].second - s[i].first);
    }

    // for (int i = 1; i <= n; i++) {
    //     int u = s[i].first;
    //     int v = s[i].second;
    //
    //     if (u > s[i - 1].first && i > 1) {
    //         for (int j = s[i - 1].first; j <= u; j++) {
    //             f[j] = max(f[j], f[j - 1]);
    //         }
    //     }
    //
    //     res = max(res, v - u + f[u - 1]);
    //     f[v] = max(f[v], v - u);
    // }

    if (res == 0) cout << -1; else
    cout << res << endl;


}
