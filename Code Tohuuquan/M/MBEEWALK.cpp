#include <iostream>
#include <queue>
#include <cstring>
using namespace std;

const int MAX = 100, MAXN = 15;
const int dx[] = { 0, -1, -1, 0, 1, 1 };
const int dy[] = { -2, -1, 1, 2, 1, -1 };
const int sx = 50, sy = 50;

struct TInfo {
    int x, y, t;
    TInfo(int _x, int _y, int _t) {
        x = _x; y = _y; t = _t;
    }
};

int a[MAX][MAX][MAXN];
int T, n;

int main() {
    scanf("%d", &T);
    while (T--) {
        scanf("%d", &n);

        memset(a, 0, sizeof(a));
        a[sx][sy][0] = 1;
        queue <TInfo> Q;
        Q.push(TInfo(sx, sy, 0));

        while (Q.size()) {
            TInfo u = Q.front(); Q.pop();
            for (int i = 0; i < 6; i++) {
                TInfo v(u.x + dx[i], u.y + dy[i], u.t + 1);
                if (a[v.x][v.y][v.t] == 0) {
                    a[v.x][v.y][v.t] = a[u.x][u.y][u.t];
                    if (v.t < n) Q.push(v);
                }
                else a[v.x][v.y][v.t] += a[u.x][u.y][u.t];
            }
        }

        printf("%d\n", a[sx][sy][n]);
    }
}
