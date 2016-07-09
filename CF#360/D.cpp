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

const int MAXN = (int) 1e6 + 100;
inline int in() { int x; scanf("%d", &x); return x; }

int isP[MAXN], cntP[MAXN];
int n, k;

int main() {
    freopen("D.txt", "r", stdin);

    FOR(i, 2, MAXN) {
        if (!isP[i]) {
            for (int j = i; j < MAXN; j += i) {
                isP[j] = i;
            }
        }
    }

    n = in(), k = in();
    FOR(i, 1, n) {
        int x;
        x = in();

        while (x > 1) {
            int p = isP[x];
            int cnt = 0;

            while (x % p == 0) {
                cnt ++;
                x = x/p;
            }

            cntP[p] = max(cntP[p], cnt);
        }
    }

    bool ok = true;
    while (k > 1) {
        if (cntP[isP[k]] <= 0) {
            ok = false;
            break;
        }

        cntP[isP[k]] --;
        k /= isP[k];
    }

    cout << (ok ? "Yes\n" : "No\n");



}
