#include <iostream>
#include <queue>
#include <vector>
#include <cstring>
#include <algorithm>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

const int MAXN = 205;
const int oo = (int)1e9;

int a[MAXN][MAXN];
bool avail[MAXN];
vector <int> b[MAXN];
int n, k;

int main() {
    scanf("%d %d", &n, &k);
    FOR(i, 1, n) FOR(j, 1, n) scanf("%d", &a[i][j]);

    int lo = 0, hi = 32767, x;
    while (lo <= hi) {
        int mid = (lo + hi) / 2, cnt = 0;
        memset(avail, true, sizeof(avail));
        FOR(i, 1, n)
            if (avail[i]) {
                ++cnt;
                queue <int> Q;
                avail[i] = false; Q.push(i);

                while (Q.size()) {
                    int u = Q.front(); Q.pop();
                    FOR(v, 1, n)
                        if (avail[v] && a[u][v] <= mid) {
                            avail[v] = false;
                            Q.push(v);
                        }
                }
            }

        if (cnt == k) { x = mid; break; }
        if (cnt < k) hi = mid - 1; else lo = mid + 1;
    }

    memset(avail, true, sizeof(avail));
    int cnt = 0;
    FOR(i, 1, n)
        if (avail[i]) {
            ++cnt;
            queue <int> Q;
            avail[i] = false; Q.push(i);

            while (Q.size()) {
                int u = Q.front(); Q.pop();
                b[cnt].push_back(u);
                FOR(v, 1, n)
                    if (avail[v] && a[u][v] <= x) {
                        avail[v] = false;
                        Q.push(v);
                    }
            }
        }

    int res = oo;
    FOR(i, 1, cnt - 1) FOR(j, i + 1, cnt) {
        int f = oo;
        for (int u = 0; u < b[i].size(); u++)
            for (int v = 0; v < b[j].size(); v++)
                f = min(f, a[b[i][u]][b[j][v]]);
        res = min(res, f);
    }
    printf("%d", res);
}
