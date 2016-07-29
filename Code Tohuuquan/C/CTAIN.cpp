#include <cstdio>
#include <cstring>
#include <vector>
#include <queue>
using namespace std;

const int MAXN = 4;
const int BASE = 50;
const int SIZE = BASE * BASE * BASE * BASE + 5;
const int b[] = { 1, 50, 2500, 125000 };

int cap[MAXN], d[SIZE];
int nTests, n, start, finish;

int StateToID(vector <int> T) {
    int res = 0;
    for (int i = 0; i < n; i++)
        res += T[i] * b[i];
    return res;
}

vector <int> IDToState(int id) {
    vector <int> T(n);
    for (int i = 0; i < n; i++) {
        T[i] = id % BASE;
        id /= BASE;
    }
    return T;
}

void Enter() {
    scanf("%d", &n);

    vector <int> T(n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &cap[i]);
        T[i] = cap[i];
    }
    start = StateToID(T);

    for (int i = 0; i < n; i++)
        scanf("%d", &T[i]);
    finish = StateToID(T);
}

inline bool Update(int v, int u) {
    if (d[v] < 0) {
        d[v] = d[u] + 1;
        return true;
    }
    return false;
}

void Solve() {
    memset(d, -1, sizeof(d));
    queue <int> Q;
    Q.push(start);
    d[start] = 0;

    while (Q.size()) {
        int id_u = Q.front(); Q.pop();
        vector <int> u = IDToState(id_u);

        // Move 1 & 2
        for (int i = 0; i < n; i++)
            for (int j = 0; j < n; j++)
                if (i != j) {
                    vector <int> v = u;
                    v[j] += v[i];
                    if (v[j] > cap[j])
                        v[i] = v[j] - cap[j], v[j] = cap[j];
                    else
                        v[i] = 0;

                    int id_v = StateToID(v);
                    if (Update(id_v, id_u))
                        if (id_v != finish) Q.push(id_v);
                        else return;
                }

        // Move 3
        for (int i = 0; i < n; i++)
            if (u[i]) {
                vector <int> v = u;
                v[i] = 0;

                int id_v = StateToID(v);
                if (Update(id_v, id_u))
                    if (id_v != finish) Q.push(id_v);
                    else return;
            }
    }
}

void Print() {
    if (d[finish] < 0)
        printf("NO\n");
    else
        printf("%d\n", d[finish]);
}

int main() {
    scanf("%d", &nTests);
    while (nTests--) {
        Enter();
        Solve();
        Print();
    }
}
