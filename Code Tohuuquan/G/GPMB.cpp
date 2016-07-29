#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>
#include <cstdlib>
#define FR(i, a, b) for(int i = a; i < b; i++)
using namespace std;

const int MAXN = 1510;
const double eps = 1e-15;

struct TPlace {
    int x, y, s;
};

struct TInfo {
    int vx, vy, id;

    TInfo(int _vx, int _vy, int _id) {
        if (_vy < 0) {
            _vx = - _vx;
            _vy = - _vy;
        }
        vx = _vx; vy = _vy; id = _id;
    }

    bool operator < (TInfo b) const {
        if (vy != 0 && b.vy == 0) return true;
        if (vy == 0 || b.vy == 0) return false;
        return vx * b.vy < vy * b.vx;
    }
};

TPlace a[MAXN];
int n, res = 0;

int main() {
    scanf("%d", &n);
    FR(i, 0, n) {
        scanf("%d %d %d", &a[i].x, &a[i].y, &a[i].s);
        a[i].s = a[i].s * a[i].s + 5;
    }

    FR(i, 0, n) {
        vector <TInfo> c;
        FR(j, i + 1, n)
            c.push_back(TInfo(a[i].x - a[j].x, a[i].y - a[j].y, j));
        sort(c.begin(), c.end());

        int sum = a[i].s;
        FR(j, 0, c.size()) {
            sum += a[c[j].id].s;
            if (j == c.size() - 1 || c[j] < c[j + 1]) {
                res = max(res, sum);
                sum = a[i].s;
            }
        }
    }

    printf("%d", res);
}
