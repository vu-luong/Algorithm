#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

const int MAXN = 300005;
const int BASE = 1000000007;
const int oo = (int)1e9;

struct Point {
    int x, y;
    Point() {}
    Point(int _x, int _y) {
        x = _x; y = _y;
    }
};

bool cmp(const Point &a, const Point &b) {
    if (a.x != b.x) return a.x < b.x;
    return a.y > b.y;
}

typedef pair <Point, int> TPair;

vector <TPair> L[MAXN];
int sum[MAXN];
Point p[MAXN];
int n;

void Add(int pos, Point x, int value) {
    sum[pos] = (sum[pos] + value) % BASE;
    L[pos].push_back(TPair(x, (L[pos].back().second + value) % BASE));
}

int main() {
    scanf("%d", &n);
    for (int i = 0; i < n; i++)
        scanf("%d %d", &p[i].x, &p[i].y);
    sort(p, p + n, cmp);

    for (int i = 0; i <= n; i++)
        L[i].push_back(TPair(Point(-oo, oo), 0));
    Add(0, Point(-oo, -oo), 1);

    int res = 0;
    for (int i = 0; i < n; i++) {
        int lo = 0, hi = n;
        while (lo < hi) {
            int mid = (lo + hi + 1) / 2;
            if (L[mid].back().first.y >= p[i].y) hi = mid - 1;
            else lo = mid;
        }
        int A = lo;

        lo = 0, hi = L[A].size() - 1;
        while (lo < hi) {
            int mid = (lo + hi + 1) / 2;
            if (L[A][mid].first.y < p[i].y) hi = mid - 1;
            else lo = mid;
        }
        int B = lo;

        Add(A + 1, p[i], (sum[A] - L[A][B].second) % BASE);
        res = max(res, A + 1);
    }

    printf("%d\n", res);
    printf("%d\n", (L[res].back().second + BASE) % BASE);
}
