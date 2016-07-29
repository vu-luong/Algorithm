#include <cstdio>
#include <cmath>
#include <vector>
#include <algorithm>
using namespace std;

const int MAXN = 100005, MAXM = MAXN;
const double INF = 2e5;
const double eps = 1e-8;

int a[MAXN], x[MAXM], y[MAXM];
int N, M, line;

void Enter() {
    scanf("%d %d", &N, &line);
    for (int i = 0; i < N; i++)
        scanf("%d", a + i);
    sort(a, a + N);

    scanf("%d", &M);
    for (int i = 0; i < M; i++) {
        scanf("%d %d", &x[i], &y[i]);
        y[i] -= line;
    }
}

inline bool Upper(double u, double v) {
    if (abs(u - v) < eps) return false;
    return u > v;
}

bool Check(double dist) {
    vector < pair <double, double> > T;

    for (int i = 0; i < M; i++)
        if (dist > abs(y[i])) {
            double d = sqrt(dist * dist - y[i] * y[i]);
            T.push_back(make_pair(x[i] - d, x[i] + d));
        }
    if (T.empty()) return false;

    sort(T.begin(), T.end());

    int j = 0;
    for (int i = 0; i < N; i++) {
        while (j < T.size() && Upper(a[i], T[j].second)) ++j;
        if (Upper(a[i], T[j].second) || Upper(T[j].first, a[i])) return false;
    }
    return true;
}

void Solve() {
    double lo = 0, hi = INF;
    while (lo + eps < hi) {
        double mid = (lo + hi) / 2;
        if (Check(mid))
            hi = mid;
        else
            lo = mid;
    }

    printf("%.6lf\n", (lo + hi) / 2);
}

int main() {
    Enter();
    Solve();
}
