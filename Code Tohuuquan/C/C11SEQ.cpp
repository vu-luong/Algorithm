#include <cstdio>
#include <algorithm>
using namespace std;

const int MAXN = 100005;

typedef long long int64;

int64 S[MAXN];
int id[MAXN], nodeL[MAXN], nodeH[MAXN];
int N, L, R;
int64 res = 0;

bool cmp(int u, int v) { return S[u] < S[v]; }

void UpdateL(int x) {
    while (x <= N) {
        ++nodeL[x];
        x += x & -x;
    }
}

void UpdateH(int x) {
    while (x <= N) {
        ++nodeH[x];
        x += x & -x;
    }
}

int Get(int x) {
    int res = 0;
    while (x > 0) {
        res += nodeH[x] - nodeL[x];
        x -= x & -x;
    }
    return res;
}

int main() {
    scanf("%d %d %d", &N, &L, &R);
    for (int i = 1; i <= N; i++) {
        int x; scanf("%d", &x);
        S[i] = S[i - 1] + x;
        id[i] = i;
        res += (L <= S[i] && S[i] <= R);
    }
    sort(id + 1, id + N + 1, cmp);

    int lo = 1, hi = 1;
    for (int i = 1; i <= N; i++) {
        while (lo <= N && S[id[lo]] <  S[id[i]] - R) UpdateL(id[lo++]);
        while (hi <= N && S[id[hi]] <= S[id[i]] - L) UpdateH(id[hi++]);

        res += Get(id[i]);
        if (L <= 0 && 0 <= R) --res;
    }

    printf("%lld", res);
}
