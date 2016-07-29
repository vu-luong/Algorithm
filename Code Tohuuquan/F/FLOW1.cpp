#include <iostream>
#include <vector>
#include <queue>
#include <sstream>
#include <cstring>
using namespace std;

const int MAX_PER = 260, MAX_PROB = 260;
const int MAXN = MAX_PER * 2 + MAX_PROB * 2 + 2;

struct TEdge {
    int x, y, c, f;
    TEdge(int _x, int _y, int _c) {
        x = _x; y = _y; c = _c; f = 0;
    }
};

vector <TEdge> e;
vector <int> h[MAXN];
int trace[MAXN], r1[MAX_PROB], r2[MAX_PROB];
int n, m, nPer, nProb, start, finish;

void MakeEdge(int u, int v, int cap) {
    h[u].push_back(e.size());
    e.push_back(TEdge(u, v, cap));
}

void Enter() {
    scanf("%d %d", &nPer, &nProb);
    n = nPer * 2 + nProb * 2;
    start = n + 1;
    finish = n + 2;

    for (int i = 1; i <= nPer; i++) {
        MakeEdge(start, i, 1);
        MakeEdge(nPer + nProb * 2 + i, finish, 1);
    }
    for (int i = 1; i <= nProb; i++)
        MakeEdge(nPer + i, nPer + nProb + i, 1);

    string st; getline(cin, st);
    for (int i = 1; i <= nPer; i++) {
        getline(cin, st);
        stringstream ss; ss << st;
        int x;
        while (ss >> x)
            MakeEdge(i, nPer + x, 1);
    }
    for (int i = 1; i <= nPer; i++) {
        getline(cin, st);
        stringstream ss; ss << st;
        int x;
        while (ss >> x)
            MakeEdge(nPer + nProb + x, nPer + nProb * 2 + i, 1);
    }

    m = e.size();
    for (int i = 0; i < m; i++)
        MakeEdge(e[i].y, e[i].x, 0);
}

bool FindPath() {
    memset(trace, 0, sizeof(trace));
    queue <int> Q;
    trace[start] = 1;
    Q.push(start);

    while (Q.size()) {
        int u = Q.front(); Q.pop();
        for (int it = 0; it < h[u].size(); it++) {
            int i = h[u][it], v = e[i].y;
            if (trace[v] == 0 && e[i].f < e[i].c) {
                trace[v] = i;
                if (v == finish) return true;
                Q.push(v);
            }
        }
    }
    return false;
}

void IncFlow() {
    int v = finish;
    while (v != start) {
        int i = trace[v];
        ++e[i].f;
        --e[(i + m) % (2 * m)].f;
        v = e[i].x;
    }
}

void Solve() {
    while (FindPath()) IncFlow();

    for (int u = 1; u <= nPer; u++)
        for (int it = 0; it < h[u].size(); it++) {
            int i = h[u][it];
            if (e[i].f > 0) {
                r1[e[i].y - nPer] = u;
                break;
            }
        }
    for (int u = nPer + nProb + 1; u <= n - nPer; u++)
        for (int it = 0; it < h[u].size(); it++) {
            int i = h[u][it];
            if (e[i].f > 0) {
                r2[u - (nPer + nProb)] = e[i].y - (nPer + nProb * 2);
                break;
            }
        }
}

void Print() {
    for (int i = 1; i <= nProb; i++)
        printf("%d %d\n", r1[i], r2[i]);
}

int main() {
    Enter();
    Solve();
    Print();
}
