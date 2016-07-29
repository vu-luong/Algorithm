#include <iostream>
#include <vector>
#include <queue>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

const int MAXN = 21;

int bit[MAXN], d[1 << 21];
vector <int> head[MAXN];
int n, k, start, finish;

void Enter() {
    scanf("%d %d", &n, &k);
    bit[1] = 1;
    FOR(i, 2, n) bit[i] = bit[i - 1] << 1;

    int s, x;
    FOR(i, 1, n) {
        scanf("%d", &s);
        FOR(j, 1, s) scanf("%d", &x), head[i].push_back(x);
    }

    start = 0; finish = bit[k];
    FOR(i, 1, n) scanf("%d", &x), start += x * bit[i];
}

inline int Change(int u, int i) {
    u += ((u & bit[i]) == 0) * bit[i];
    for (int j = 0; j < head[i].size(); j++) {
        int x = head[i][j];
        u -= ((u & bit[x]) != 0) * bit[x];
    }
    return u;
}

void Solve() {
    queue <int> Q;
    d[start] = 1; Q.push(start);
    while (Q.size()) {
        int u = Q.front(); Q.pop();
        FOR(i, 1, n) {
            int v = Change(u, i);
            if (d[v] == 0) {
                d[v] = d[u] + 1;
                if (v == finish) return;
                Q.push(v);
            }
        }
    }
}

void Print() {
    printf("%d", d[finish] - 1);
}

int main() {
    Enter();
    Solve();
    Print();
}
