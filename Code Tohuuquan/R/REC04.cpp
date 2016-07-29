#include <iostream>
#include <algorithm>
#include <cmath>
#define sqr(x) ((x) * (x))
using namespace std;

const int MAXN = 1501;
const int MAXM = MAXN * (MAXN - 1) / 2;

typedef long long int64;
typedef pair <int, int> TPoint;

struct TSeq {
    TPoint mid;
    int64 len;
    int p1, p2;
};

TSeq s[MAXM];
int64 x[MAXN], y[MAXN];
int n, m = 0;
int64 res = 0;

void Enter() {
    scanf("%d", &n);
    for (int i = 0; i < n; i++)
        scanf("%lld %lld", &x[i], &y[i]);
}

bool cmp(TSeq u, TSeq v) {
    if (u.mid != v.mid)
        return u.mid < v.mid;
    if (u.len != v.len)
        return u.len < v.len;
    return false;
}

void Init() {
    for (int i = 0; i < n; i++)
        for (int j = i + 1; j < n; j++) {
            s[m].mid = TPoint(x[i] + x[j], y[i] + y[j]);
            s[m].len = sqr(x[i] - x[j]) + sqr(y[i] - y[j]);
            s[m].p1 = i;
            s[m].p2 = j;
            ++m;
        }

    sort(s, s + m, cmp);
}

inline double Dist(int a, int b) {
    return sqrt(sqr(x[a] - x[b]) + sqr(y[a] - y[b]));
}

inline double Cal(int a, int b, int c) {
    return ceil(Dist(a, b) * Dist(a, c) - 0.5);
}

void Solve() {
    for (int i = 0; i < m; ) {
        int j = i;
        while (j < m && s[i].mid == s[j].mid && s[i].len == s[j].len) ++j;

        for (int u = i; u < j; u++)
            for (int v = u + 1; v < j; v++)
                res = max(res, (int64)Cal(s[u].p1, s[v].p1, s[v].p2));

        i = j;
    }
}

void Print() {
    printf("%lld", res);
}

int main() {
    Enter();
    Init();
    Solve();
    Print();
}
