#include <iostream>
#include <algorithm>
using namespace std;

const int MAXN = 30005;
const int MAXQ = 200000;

struct TQues {
    int x, y, k;
};

int a[MAXN], d1[MAXN], d2[MAXQ];
int node[MAXN], res[MAXQ];
TQues b[MAXQ];
int n, q;

bool cmp1(int u, int v) { return a[u] > a[v]; }

bool cmp2(int u, int v) { return b[u].k > b[v].k; }

void Enter() {
    scanf("%d", &n);
    for (int i = 0; i < n; i++) {
        scanf("%d", a + i);
        d1[i] = i;
    }
    sort(d1, d1 + n, cmp1);

    scanf("%d", &q);
    for (int i = 0; i < q; i++) {
        scanf("%d %d %d", &b[i].x, &b[i].y, &b[i].k);
        d2[i] = i;
    }
    sort(d2, d2 + q, cmp2);
}

void Update(int x) {
    while (x <= n) {
        ++node[x];
        x += x & -x;
    }
}

int Get(int x) {
    int res = 0;
    while (x > 0) {
        res += node[x];
        x -= x & -x;
    }
    return res;
}

void Solve() {
    int last = 0;
    for (int i = 0; i < q; ) {
        int j = i;
        while (j < q && b[d2[i]].k == b[d2[j]].k) ++j;

        while (last < n && a[d1[last]] > b[d2[i]].k) {
            Update(d1[last] + 1);
            ++last;
        }

        for (int x = i; x < j; x++)
            res[d2[x]] = Get(b[d2[x]].y) - Get(b[d2[x]].x - 1);
        i = j;
    }
}

void Print() {
    for (int i = 0; i < q; i++)
        printf("%d\n", res[i]);
}

int main() {
    Enter();
    Solve();
    Print();
}
