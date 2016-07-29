#include <cstdio>
#include <cmath>
#include <algorithm>
using namespace std;

const int MAXN = 10000;
const int MAXD = 500;

struct TInfo {
    int x, y, r;

    bool operator < (TInfo u) const {
        if (x != u.x) return x < u.x;
        return y < u.y;
    }
};

TInfo a[MAXN];
int N;
double res = 1e9;

inline double sqr(double x) {
    return x * x;
}

inline double Dist(TInfo u, TInfo v) {
    return sqrt(sqr(u.x - v.x) + sqr(u.y - v.y)) - (u.r + v.r);
}

int main() {
    scanf("%d", &N);
    for (int i = 0; i < N; i++)
        scanf("%d %d %d", &a[i].x, &a[i].y, &a[i].r);

    sort(a, a + N);

    for (int i = 0; i < N; i++)
        for (int j = i + 1; j < min(N, i + MAXD); j++)
            res = min(res, Dist(a[i], a[j]));

    printf ("%.4lf", double((long long)(res * 10000)) / 10000);
}
