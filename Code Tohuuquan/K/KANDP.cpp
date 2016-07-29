#include <iostream>
#include <cstring>
#include <queue>
#include <algorithm>
#define FR(i, a, b) for(int i = a; i < b; i++)
using namespace std;

const int MAX = 2050;
const int dx[] = { -2, -2, -1, 1, 2, 2, 1, -1 };
const int dy[] = { -1, 1, 2, 2, 1, -1, -2, -2 };

struct TCoord {
    int x, y;
    TCoord() {}
    TCoord(int _x, int _y) {
        x = _x; y = _y;
    }
};

int d[MAX][MAX];
int flag, maxx, maxy;
queue <TCoord> Q;
TCoord m, t;

int main() {
    scanf("%d %d %d %d %d", &m.x, &m.y, &t.x, &t.y, &flag);

    int minx = min(m.x, t.x), miny = min(m.y, t.y);
    m = TCoord(m.x - minx + 10, m.y - miny + 10);
    t = TCoord(t.x - minx + 10, t.y - miny + 10);
    maxx = max(m.x, t.x) + 10;
    maxy = max(m.y, t.y) + 10;

    memset(d, -1, sizeof(d));
    if (flag == 0)
        FR(i, 0, 8) {
            TCoord u = TCoord(m.x + dx[i], m.y + dy[i]);
            if (u.x != t.x - 1 || u.y != t.y) {
                Q.push(u);
                d[u.x][u.y] = 1;
            }
            if (u.x == t.x && u.y == t.y) {
                printf("YES\n1");
                return 0;
            }
        }
    else if (m.x != t.x - 1 || m.y != t.y) {
        Q.push(m);
        d[m.x][m.y] = 0;
    }

    while (Q.size()) {
        TCoord u = Q.front(); Q.pop();
        FR(i, 0, 8) {
            TCoord v(u.x + dx[i] + 1, u.y + dy[i]);
            if (v.x < 0 || v.x > maxx || v.y < 0 || v.y > maxy) continue;
            if (d[v.x][v.y] < 0) {
                d[v.x][v.y] = d[u.x][u.y] + 1;
                Q.push(v);
                if (v.x == t.x && v.y == t.y) {
                    printf("YES\n%d", d[v.x][v.y]);
                    return 0;
                }
            }
        }
    }

    printf("NO");
}
