#include <cstdio>
#include <cstring>
using namespace std;

const int MAXN = 1001;
const int MAXM = MAXN * MAXN;
const int MAXQ = (int)1e6 + 5;

struct TEdge {
    int x, y;

    TEdge() {}
    TEdge(int _x, int _y) {
        x = _x; y = _y;
    }
};

bool a0[MAXN][MAXN], a1[MAXN][MAXN];
int node[MAXM];
TEdge e[MAXQ];
int n, now, m = MAXM - 1, front = 1, rear = 0;
char s[3];

inline void Update(int x, int value) {
    while (x <= m) {
        node[x] += value;
        x += x & -x;
    }
}

inline int Get(int x) {
    int res = 0;
    while (x > 0) {
        res += node[x];
        x -= x & -x;
    }
    return res;
}

inline int ID(int u, int v) { return (u - 1) * n + v; }

void Init() {
    memset(a1, true, sizeof(a1));
    for (int i = 1; i < MAXM; i++) Update(i, 1);
}

void SolveNEW() {
    if (now)
        while (front <= rear) {
            TEdge u = e[front++];
            if (!a1[u.x][u.y]) {
                a1[u.x][u.y] = true;
                Update(ID(u.x, u.y), 1);
            }
        }
    else
        while (front <= rear) {
            TEdge u = e[front++];
            a0[u.x][u.y] = false;
        }

    front = 1; rear = 0;
    scanf("%d %d\n", &n, &now);
    m = n * n;
}

void Solve0() {
    while (true) {
        scanf("%s", &s);
        if (strcmp(s, "NEW") == 0 || strcmp(s, "END") == 0) break;

        int u, v;
        if (strcmp(s, "ADD") == 0) {
            scanf("%d %d\n", &u, &v);
            if (a0[u][v]) continue;
            a0[u][v] = true;
            e[++rear] = TEdge(u, v);
        }
        else if (strcmp(s, "DEL") == 0) {
            scanf("%d %d\n", &u, &v);
            a0[u][v] = false;
        }
        else if (strcmp(s, "ANY") == 0) {
            scanf("\n");

            bool res = false;
            while (front <= rear) {
                TEdge u = e[front++];
                if (a0[u.x][u.y]) {
                    a0[u.x][u.y] = false;
                    printf("%d %d\n", u.x, u.y);
                    res = true;
                    break;
                }
            }
            if (!res) printf("-1\n");
        }
        else if (strcmp(s, "EDG") == 0) {
            scanf("%d %d\n", &u, &v);
            puts(a0[u][v] ? "YES" : "NO");
        }
    }
}

void Solve1() {
    while (true) {
        scanf("%s", &s);
        if (strcmp(s, "NEW") == 0 || strcmp(s, "END") == 0) break;

        int u, v;
        if (strcmp(s, "ADD") == 0) {
            scanf("%d %d\n", &u, &v);
            if (a1[u][v]) continue;
            a1[u][v] = true;
            Update(ID(u, v), 1);
        }
        else if (strcmp(s, "DEL") == 0) {
            scanf("%d %d\n", &u, &v);
            if (!a1[u][v]) continue;

            a1[u][v] = false;
            e[++rear] = TEdge(u, v);
            Update(ID(u, v), -1);
        }
        else if (strcmp(s, "ANY") == 0) {
            scanf("\n");
            if (Get(m) == 0) {
                printf("-1\n");
                continue;
            }

            int lo = 1, hi = m;
            while (lo < hi) {
                int mid = (lo + hi) >> 1;
                if (Get(mid) < 1)
                    lo = mid + 1;
                else
                    hi = mid;
            }

            u = (lo - 1)/ n + 1, v = lo - (u - 1) * n;
            a1[u][v] = false;
            e[++rear] = TEdge(u, v);
            Update(ID(u, v), -1);

            printf("%d %d\n", u, v);
        }
        else if (strcmp(s, "EDG") == 0) {
            scanf("%d %d\n", &u, &v);
            puts(a1[u][v] ? "YES" : "NO");
        }
    }
}

int main() {
    Init();

    do scanf("%s", &s);
    while (strcmp(s, "NEW") != 0 && strcmp(s, "END") != 0);

    while (true)
        if (strcmp(s, "END") == 0) break;
        else {
            SolveNEW();
            if (now) Solve1(); else Solve0();
        }
}
