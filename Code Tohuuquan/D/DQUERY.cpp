#include <iostream>
#include <algorithm>
using namespace std;

const int MAXN = 30005;
const int MAXQ = 200005;

struct TQues { int x, y; };

int a[MAXN], p[MAXN], d1[MAXN], d2[MAXQ];
int node[MAXN], res[MAXQ];
TQues b[MAXQ];
int n, q;

bool cmp1(int u, int v) {
    if (a[u] != a[v]) return a[u] < a[v];
    return u < v;
}

bool cmp2(int u, int v) { return p[u] > p[v]; }

bool cmp3(int u, int v) { return b[u].x > b[v].x; }

void Enter() {
    scanf("%d", &n);
    for (int i = 0; i < n; i++) {
        scanf("%d", a + i);
        d1[i] = i;
    }
    sort(d1, d1 + n, cmp1);

    p[d1[0]] = 0;
    for (int i = 1; i < n; i++)
        p[d1[i]] = (a[d1[i]] == a[d1[i - 1]] ? d1[i - 1] + 1 : 0);
    for (int i = 0; i < n; i++) d1[i] = i;
    sort(d1, d1 + n, cmp2);

    scanf("%d", &q);
    for (int i = 0; i < q; i++) {
        scanf("%d %d", &b[i].x, &b[i].y);
        d2[i] = i;
    }
    sort(d2, d2 + q, cmp3);
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
        while (j < q && b[d2[i]].x == b[d2[j]].x) ++j;

        while (last < n && p[d1[last]] >= b[d2[i]].x) {
            Update(d1[last] + 1);
            ++last;
        }

        for (int x = i; x < j; x++) {
            int id = d2[x];
            res[id] = (b[id].y - b[id].x + 1)
                    - (Get(b[id].y) - Get(b[id].x - 1));
        }
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
