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
#include <queue>

#define PB push_back
#define MP make_pair
#define SZ(a) a.size()
#define DEBUG(x) cout << #x << " = " << x << endl;

#define PR(A,n)  { cout << #A << " = "; for (int i = 1, _n = (n); i <= _n; i++) \
    cout << A[i] << ' '; cout << endl; }
#define PR0(A,n) { cout << #A << " = "; for (int i = 0, _n = (n); i < _n; i++) \
    cout << A[i] << ' '; cout << endl; }

using namespace std;
const int MAXN = (int) 1e4 + 5;
const int dx[4] = {-1, 0, 0, 1};
const int dy[4] = {0, -1, 1, 0};

int a[MAXN][MAXN];
queue< pair<int, int> > q, p;
bool fr[MAXN][MAXN];
int m, n, k;


int main() {
        freopen("D.txt", "r", stdin);

    scanf("%d %d %d", &n, &m, &k);
    memset(fr, true, sizeof(fr));

    for (int i = 1; i <= k; i++) {
        int u, v;
        scanf("%d %d", &u, &v);
        a[u][v] = 1;
    }


    q.push(make_pair(1, 1));

    int res = 0;

    while (true) {

        while (!q.empty()) {
            int u = q.front().first;
            int v = q.front().second;
            q.pop();

            for (int i = 0; i < 4; i++) {
                int uu = u + dx[i];
                int vv = v + dy[i];

                if (!fr[uu][vv]) continue;
                if (a[uu][vv] == 1) {
                    q.push(MP(uu, vv));
                    fr[uu][vv] = false;
                    if (uu == n && vv == m) {
                        cout << res << endl;
                        return 0;
                    }
                } else {
                    if (a[u][v] == 0 || !(u >= 1 && u <= n && v >= 1 && v <= m)) continue;
                    if (a[uu][vv] == 0) {
                        p.push(MP(uu, vv));
                        fr[uu][vv] = false;
                        res++;
                    }
                }


            }
        }

        res++;

        while (!p.empty()) {
            int u = p.front().first;
            int v = p.front().second;
            p.pop();

            q.push(MP(u, v));
        }

        if (!fr[n][m]) {
            if (a[n][m] == 0)
            cout << res + 1 << endl;
            return 0;
        }

        if (q.empty()) {
            cout << "-1" << endl;
            return 0;
        }


    }

}
