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

const int MAXN = (int) 2e5 + 5;
const int INF = (int) 1e9 + 7;

int T1[MAXN*8], T2[MAXN*8];
int a[MAXN], b[MAXN];
int qmax, qmin;
int n;

void init(int u, int l, int r) {

    if (l == r) {
        T1[u] = a[l];
        T2[u] = b[l];
        return;
    }

    int mid = (l + r) / 2;

    init(u * 2, l, mid);
    init(u * 2 + 1, mid + 1, r);

    T1[u] = max(T1[u * 2], T1[u * 2 + 1]);
    T2[u] = min(T2[u * 2], T2[u * 2 + 1]);
}

void query(int x, int l, int r, int u, int v) {

    if (l > v || r < u) {
        return;
    }

    if (u <= l && r <= v) {
        qmax = max(qmax, T1[x]);
        qmin = min(qmin, T2[x]);
        return;
    }

    int mid = (l + r) / 2;

    query(x * 2, l, mid, u, v);
    query(x * 2 + 1, mid + 1, r, u, v);
}

int main() {
    // freopen("D.txt", "r", stdin);

    scanf("%d", &n);

    for (int i = 1; i <= n; i++) {
        scanf("%d", &a[i]);
    }
    for (int i = 1; i <= n; i++) {
        scanf("%d", &b[i]);
    }

    init(1, 1, n);

    long long res = 0;
    int r1, r2;

    for (int i = 1; i <= n; i++) {

        int first = i - 1;
        int last = n + 1;
        bool ok = false;

        while (first + 1 < last) {
            int mid = (first + last) / 2;
            qmax = -INF; qmin = INF;
            query(1, 1, n, i, mid);
            if (qmax == qmin) ok = true;
            if (qmax >= qmin) last = mid;
            else first = mid;
        }

        if (last != n + 1 && ok) {
            r1 = last;
        } else continue;

        first = i - 1;
        last = n + 1;
        ok = false;
        while (first + 1 < last) {
            int mid = (first + last) / 2;
            qmax = -INF; qmin = INF;
            query(1, 1, n, i, mid);
            if (qmax == qmin) ok = true;
            if (qmax <= qmin) first = mid;
            else last = mid;
        }

        if (first != i - 1 && ok) {
            r2 = first;
        } else continue;

        if (r2 >= r1) res = res + (r2 - r1 + 1);
    }

    cout << res << endl;


}
