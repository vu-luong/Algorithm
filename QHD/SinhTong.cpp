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

#define FOR(i, a, b) for (int _b = (b), i = (a); i <= _b; i++)
#define FORD(i, a, b) for (int _b = (b), i = (a); i >= _b; i--)
#define REP(i, a) for (int i = 0, _a = (a); i < _a; i++)
#define FIT(it, v) for (typeof((v).begin()) it = (v).begin(); it != (v).end(); it++)

using namespace std;
const int MAXS = 5005;
const int MAXN = 105;
inline int in() { int t; scanf("%d", &t); return t; }

int f[MAXS];
int a[MAXN];
int main() {
    freopen("SinhTong.txt", "r", stdin);

    int n = in();
    int s = in();
    FOR (i, 1, n) {
        a[i] = in();
    }

    f[0] = -1;

    FOR(i, 1, s) {
        FOR(j, 1, n) {
            if (i >= a[j]) {
                if (f[i - a[j]] < j && f[i - a[j]] != 0) {
                    f[i] = j;
                    break;
                }
            }
        }
    }

    FOR (i, 1, s) {
        cout << i << " " << f[i] << endl;
    }


}
