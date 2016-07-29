#include <cstdio>
using namespace std;

const int MAXR = 105, MAXC = 105;
const int oo = MAXR * MAXC * 5 + 1;
const int dx[] = { 1, 0, 1 };
const int dy[] = { 0, 1, 1 };

char a[MAXR][MAXC];
int f[MAXR][MAXC];
int r, c, n;

inline bool Check(int x, int y) {
    return (0 < x && x <= r && 0 < y && y <= c);
}

inline int Val(char ch) {
    switch (ch) {
        case 'C' : return 1; break;
        case 'S' : return 3; break;
        case 'B' : return 5; break;
    }
    return 0;
}

int main() {
    scanf("%d %d", &r, &c); gets(a[0]);
    for (int i = 1; i <= r; i++) gets(a[i] + 1);

    for (int i = r; i >= 1; i--)
        for (int j = c; j >= 1; j--)
            if (a[i][j] != '#') {
                f[i][j] = oo;

                for (int k = 0; k < 4; k++) {
                    int u = i + dx[k], v = j + dy[k];
                    if (Check(u, v) && a[u][v] != '#') {
                        int t = -f[u][v] + 2 * Val(a[u][v]);
                        if (f[i][j] == oo || f[i][j] < t) f[i][j] = t;
                    }
                }

                if (f[i][j] == oo) f[i][j] = -1;
            }

    scanf("%d", &n);
    for (int i = 0; i < n; i++) {
        int x, y; scanf("%d %d", &x, &y);
        puts(f[x][y] > 0 ? "HAL" : "DAVE");
    }
}
