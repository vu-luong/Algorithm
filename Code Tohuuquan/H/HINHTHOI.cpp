#include <iostream>
#include <algorithm>
#include <cmath>
using namespace std;

const int MAXN = 1501;
const int MAXM = MAXN * (MAXN - 1);
const float oo = 2e9;
const float eps = 1e-6;

typedef pair <int, int> TPoint;

struct TSeq {
    TPoint mid;
    float slope;
    int t;
};

TSeq s[MAXM];
int x[MAXN], y[MAXN];
int n, m;
long long res = 0;

void Enter() {
    scanf("%d", &n);
    for (int i = 0; i < n; i++)
        scanf("%d %d", &x[i], &y[i]);
}

bool cmp(TSeq u, TSeq v) {
    if (u.mid != v.mid)
        return u.mid < v.mid;
    if (u.slope != v.slope)
        return u.slope < v.slope;
    return false;
}

void Init() {
    for (int i = 0; i < n; i++)
        for (int j = i + 1; j < n; j++) {
            TSeq tmp;
            tmp.mid = TPoint(x[i] + x[j], y[i] + y[j]);
            tmp.slope = (y[i] == y[j] ? oo : float(x[j] - x[i]) / (y[j] - y[i]));
            tmp.t = 0;
            s[m++] = tmp;

            tmp.slope = (x[i] == x[j] ? oo : float(y[i] - y[j]) / (x[j] - x[i]));
            tmp.t = 1;
            s[m++] = tmp;
        }

    sort(s, s + m, cmp);
}

void Solve() {
    int cnt[2];
    for (int i = 0; i < m; ) {
        cnt[0] = cnt[1] = 0;

        int j = i;
        while (j < m && s[j].mid == s[i].mid
                     && abs(s[j].slope - s[i].slope) < eps) {
            ++cnt[s[j].t];
            ++j;
        }

        res += cnt[0] * cnt[1];

        i = j;
    }
    res /= 2;
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
