#include <cstdio>
#include <algorithm>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

const int MAXN = 100005;
const int BASE = (int)1e9 + 7;

struct TInfo {
    int v, lis, id;

    bool operator < (TInfo u) const {
        if (lis != u.lis) return lis < u.lis;
        return id < u.id;
    }
};

TInfo a[MAXN];
int f[MAXN], s[MAXN];
int N;

inline int Add(int a, int b) {
    return (a + b) % BASE;
}

inline int Sub(int a, int b) {
    return (a + BASE - b) % BASE;
}

void Enter() {
    scanf("%d", &N);
    FOR(i, 1, N) {
        scanf("%d", &a[i].v);
        a[i].id = i;
    }
}

void Init() {
    int l[MAXN], d = 1;
    l[1] = 1;
    a[1].lis = 1;

    FOR(i, 2, N)
        if (a[i].v < a[l[1]].v)
            l[1] = i, a[i].lis = 1;
        else if (a[i].v > a[l[d]].v)
            l[++d] = i, a[i].lis = d;
        else {
            int lo = 1, hi = d;
            while (lo < hi) {
                int mid = (lo + hi) >> 1;
                if (a[i].v > a[l[mid]].v)
                    lo = mid + 1;
                else
                    hi = mid;
            }
            l[lo] = i;
            a[i].lis = lo;
        }

    sort(a + 1, a + N + 1);
}

int FindL(int lo, int hi, int key) {
    while (lo <= hi) {
        int mid = (lo + hi) >> 1;
        if (key < a[mid].lis)
            hi = mid - 1;
        else
            lo = mid + 1;
    }
    return lo;
}

int FindID(int lo, int hi, int key) {
    while (lo <= hi) {
        int mid = (lo + hi) >> 1;
        if (key < a[mid].id)
            hi = mid - 1;
        else
            lo = mid + 1;
    }
    return hi;
}

int FindV(int lo, int hi, int key) {
    while (lo <= hi) {
        int mid = (lo + hi) >> 1;
        if (key > a[mid].v)
            hi = mid - 1;
        else
            lo = mid + 1;
    }
    return lo;
}

void Solve() {
    int L, R, X, Y, i = 1;

    while (i <= N && a[i].lis == 1) {
        f[i] = 1;
        s[i] = Add(s[i - 1], f[i]);
        ++i;
    }

    for ( ; i <= N; i++) {
        L = FindL(1, N, a[i].lis - 2);
        R = FindL(1, N, a[i].lis - 1) - 1;

        Y = FindID(L, R, a[i].id);
        X = FindV(L, Y, a[i].v);

        f[i] = Sub(s[Y], s[X - 1]);
        s[i] = Add(s[i - 1], f[i]);
    }
}

void Print() {
    int res = 0, i = N - 1;
    while (i > 0 && a[i].lis == a[i + 1].lis) --i;
    res = Sub(s[N], s[i]);

    printf("%d", res);
}

int main() {
    Enter();
    Init();
    Solve();
    Print();
}
