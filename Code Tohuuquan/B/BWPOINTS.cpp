#include <iostream>
#include <algorithm>
#include <vector>
#define FR(i, a, b)  for(int i = a; i < b; i++)
using namespace std;

struct TPoint {
    int x, c;
    bool avail;

    TPoint(int _x, int _c, bool _avail) {
        x = _x;
        c = _c;
        avail = _avail;
    }
};

vector <TPoint> a;
int n, res = 0;

bool cmp(TPoint u, TPoint v) { return u.x < v.x; }

int main() {
    scanf("%d", &n);
    FR(i, 0, n) {
        int x;
        scanf("%d", &x);
        a.push_back(TPoint(x, 0, true));
    }
    FR(i, n, n * 2) {
        int x;
        scanf("%d", &x);
        a.push_back(TPoint(x, 1, true));
    }
    n *= 2;

    sort(a.begin(), a.end(), cmp);

    FR(i, 0, n - 1)
        if (a[i].avail && a[i + 1].avail && a[i].c != a[i + 1].c) {
            a[i + 1].avail = false;
            ++res;
        }

    printf("%d", res);
}
