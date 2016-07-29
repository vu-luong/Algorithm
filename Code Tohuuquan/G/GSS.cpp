#include <cstdio>
#include <algorithm>
using namespace std;

const int MAXN = 50005;
const int nINF = - (MAXN * 15000);

struct TNode {
    int L, R, S, A;
};

int a[MAXN];
TNode it[MAXN * 3];
int n, m, x, y;

void Init(int i, int L, int R) {
    if (L == R) {
        it[i].L = it[i].R = it[i].S = it[i].A = a[L];
        return;
    }

    int M = (L + R) >> 1;
    Init(i * 2, L, M);
    Init(i * 2 + 1, M + 1, R);

    TNode cL = it[i * 2], cR = it[i * 2 + 1];
    it[i].L = max(cL.L, cL.S + cR.L);
    it[i].R = max(cR.R, cR.S + cL.R);
    it[i].S = cL.S + cR.S;
    it[i].A = max( max(cL.A, cR.A), cL.R + cR.L );
}

TNode Find(int i, int L, int R) {
    if (L > R || y < L || x > R) {
        TNode res;
        res.L = res.R = res.S = res.A = nINF;
        return res;
    }

    if (x <= L && R <= y) return it[i];

    int M = (L + R) >> 1;
    TNode cL = Find(i * 2, L, M), cR = Find(i * 2 + 1, M + 1, R), res;

    res.L = max(cL.L, cL.S + cR.L);
    res.R = max(cR.R, cR.S + cL.R);
    res.S = max(cL.S + cR.S, nINF);
    res.A = max( max(cL.A, cR.A), cL.R + cR.L );

    return res;
}

int main() {
    scanf("%d", &n);
    for (int i = 1; i <= n; i++) scanf("%d", &a[i]);
    Init(1, 1, n);

    scanf("%d", &m);
    for (int i = 0; i < m; i++) {
        scanf("%d %d", &x, &y);
        printf("%d\n", Find(1, 1, n).A);
    }
}
