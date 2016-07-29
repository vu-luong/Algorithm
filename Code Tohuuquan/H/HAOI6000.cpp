#include <iostream>
using namespace std;

const int MAX = 1005;
const int oo = (int)1e9;

int a[MAX][MAX];
int m, n, res, cnt;

int Cal(int col) {
    int res = 0, x = 1, y = col, lab = 1;
    do {
        ++res;
        if (a[x][y])
            switch (lab) {
                case 1 : --y; lab = 2; break;
                case 2 : ++x; lab = 1; break;
                case 3 : ++y; lab = 4; break;
                case 4 : --x; lab = 3; break;
            }
        else
            switch (lab) {
                case 1 : ++y; lab = 4; break;
                case 2 : --x; lab = 3; break;
                case 3 : --y; lab = 2; break;
                case 4 : ++x; lab = 1; break;
            }
        if (x < 1 || y < 1 || y > n) return oo;
    }
    while (x <= m);
    return res;
}

int main() {
    scanf("%d %d", &m, &n);
    for (int i = 1; i <= m; i++)
        for (int j = 1; j <= n; j++) scanf("%d", &a[i][j]);

    res = oo; cnt = 0;
    for (int j = 1; j <= n; j++) {
        int s = Cal(j);
        if (s < res) res = s, cnt = 0;
        if (s == res) ++cnt;
    }

    if (res == oo) printf("0 0");
    else printf("%d %d", res, cnt);
}
