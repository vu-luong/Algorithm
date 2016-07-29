#include <cstdio>
#include <vector>
#include <queue>
using namespace std;

const int MAXM = 1005, MAXN = 105;
const int oo = (int)1e9;

int numP[MAXM], need[MAXN], val[MAXN], trace[MAXN], C[MAXN][MAXN];
vector <int> pig[MAXN], adj[MAXN];
int M, N, S1, S2, res;

void Enter() {
    scanf("%d %d", &M, &N);

    for (int i = 1; i <= M; i++)
        scanf("%d", numP + i);

    for (int i = 1; i <= N; i++) {
        int num; scanf("%d", &num);
        pig[i].resize(num);
        for (int j = 0; j < num; j++)
            scanf("%d", &pig[i][j]);
        scanf("%d", need + i);
    }
}

void Init() {
    for (int i = 1; i < N; i++)
        for (int j = i + 1; j <= N; j++)
            for (int ki = 0, kj = 0; ki < pig[i].size() && kj < pig[j].size(); )
                if (pig[i][ki] == pig[j][kj]) {
                    adj[i].push_back(j);
                    break;
                }
                else if (pig[i][ki] < pig[j][kj]) ++ki; else ++kj;

    vector <bool> avail(M + 1, true);
    for (int i = 1; i <= N; i++) {
        val[i] = -need[i];
        for (int j = 0; j < pig[i].size(); j++)
            if (avail[pig[i][j]]) {
                avail[pig[i][j]] = false;
                val[i] += numP[pig[i][j]];
            }

        res += need[i];
        if (val[i] < 0) res += val[i];
    }

    S1 = N + 1;
    S2 = N + 2;
    for (int i = 1; i <= N; i++) {
        for (int j = 0; j < adj[i].size(); j++)
            C[i][adj[i][j]] = oo;

        if (val[i] > 0) {
            adj[S1].push_back(i);
            C[S1][i] = val[i];
        }
        else if (val[i] < 0) {
            adj[i].push_back(S2);
            C[i][S2] = -val[i];
        }

    }

    for (int i = 1; i <= N; i++)
        for (int j = 0; j < adj[i].size(); j++)
            adj[adj[i][j]].push_back(i);
}

bool FindPath() {
    queue <int> Q;
    vector <bool> avail(N + 3, true);
    Q.push(S1); avail[S1] = false;

    while (Q.size()) {
        int u = Q.front(); Q.pop();
        if (u == S2) return true;

        for (int i = 0; i < adj[u].size(); i++) {
            int v = adj[u][i];
            if (avail[v] && C[u][v] > 0) {
                Q.push(v);
                avail[v] = false;
                trace[v] = u;
            }
        }
    }
    return false;
}

void IncFlow() {
    int delta = oo;
    for (int i = S2; i != S1; i = trace[i])
        delta = min(delta, C[trace[i]][i]);

    for (int i = S2; i != S1; i = trace[i]) {
        C[trace[i]][i] -= delta;
        C[i][trace[i]] += delta;
    }

    res += delta;
}

void Solve() {
    while (FindPath()) IncFlow();
    printf("%d", res);
}

int main() {
    Enter();
    Init();
    Solve();
}
