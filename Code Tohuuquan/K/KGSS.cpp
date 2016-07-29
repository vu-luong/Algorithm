#include <iostream>
#include <algorithm>
using namespace std;

const int MAXN = (int)1e5 + 5;
const int oo = (int)1e9;

typedef pair <int, int> TNode;

int a[MAXN];
TNode node[MAXN * 3];
int n, q;

void Init(int i, int L, int R) {
    if (L == R) {
        node[i].first = a[L];
        node[i].second = -oo;
        return;
    }

    int M = (L + R) >> 1;
    Init(i * 2, L, M);
    Init(i * 2 + 1, M + 1, R);

    node[i].first = max(node[i * 2].first, node[i * 2 + 1].first);
    node[i].second = max( min(node[i * 2].first, node[i * 2 + 1].first),
                          max(node[i * 2].second, node[i * 2 + 1].second) );
}

void Update(int i, int L, int R, const int pos) {
    if (pos < L || pos > R) return;
    if (L == R) {
        node[i].first = a[L];
        node[i].second = -oo;
        return;
    }

    int M = (L + R) >> 1;
    Update(i * 2, L, M, pos);
    Update(i * 2 + 1, M + 1, R, pos);

    node[i].first = max(node[i * 2].first, node[i * 2 + 1].first);
    node[i].second = max( min(node[i * 2].first, node[i * 2 + 1].first),
                          max(node[i * 2].second, node[i * 2 + 1].second) );
}

TNode Find(int i, int L, int R, const int x, const int y) {
    if (L > R || y < L || x > R) return TNode(-oo, -oo);
    if (x <= L && R <= y) return node[i];

    int M = (L + R) >> 1;
    TNode res, cL, cR;
    cL = Find(i * 2, L, M, x, y);
    cR = Find(i * 2 + 1, M + 1, R, x, y);

    res.first = max(cL.first, cR.first);
    res.second = max( min(cL.first, cR.first),
                      max(cL.second, cR.second) );

    return res;
}

int main() {
    scanf("%d", &n);
    for (int i = 1; i <= n; i++) scanf("%d", &a[i]);
    Init(1, 1, n);

    scanf("%d\n", &q);
    for (int i = 0; i < q; i++) {
        char c = getchar();
        if (c == 'U') {
            int pos, value;
            scanf("%d %d\n", &pos, &value);
            a[pos] = value;
            Update(1, 1, n, pos);
        }
        else if (c == 'Q') {
            int x, y;
            scanf("%d %d\n", &x, &y);

            TNode res = Find(1, 1, n, x, y);
            printf("%d\n", res.first + res.second);
        }
    }
}
