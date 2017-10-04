#include <bits/stdc++.h>

#define PB push_back
#define MP make_pair
#define SZ(a) a.size()
#define DEBUG(x) cout << #x << " = " << x << endl;

#define PR(A,n)  { cout << #A << " = "; for (int i = 1, _n = (n); i <= _n; i++) \
    cout << A[i] << ' '; cout << endl; }
#define PR0(A,n) { cout << #A << " = "; for (int i = 0, _n = (n); i < _n; i++) \
    cout << A[i] << ' '; cout << endl; }

using namespace std;
const int MAXN = 555;
const int MAXM = 10005;
const int inf = (int) 1e9 + 7;
int n, m, q;

struct ADJ {
    int v, w, id;
};

struct EDGE {
    int u, v, w, id;
};

FILE * pFile;
FILE * wFile;
vector <ADJ> adj[MAXN];
EDGE ed[MAXM];
queue<int> Q, qnext;
bool emark[MAXM], fr[MAXN];
int d[MAXN];
int cw[MAXN];

bool cmp(EDGE a, EDGE b) {
    return a.w < b.w;
}

void process() {
    scanf("%d %d %d", &n, &m, &q);

    for (int i = 0; i <= 151; i++) {
        adj[i].clear();
    }

    for (int i = 1; i <= m; i++) {
        int x, y, z;
        scanf("%d %d %d", &x, &y, &z);

        adj[x].PB({y, x, i});
        ed[i] = {x, y, z, i};
    }

    sort(ed + 1, ed + 1 + m, cmp);


    while (q--) {
        int a, b, c;
        scanf("%d %d %d", &a, &b, &c);

        memset(emark, false, sizeof(emark));
        memset(fr, true, sizeof(fr));
        Q = queue<int>();

        Q.push(a);

        for (int i = 1; i <= n; i++) d[i] = inf;
        d[a] = 0;

        fr[a] = false;
        
        while (!Q.empty()) {
            int u = Q.front(); Q.pop();

            if (d[u] >= c) continue;

            for (int i = 0; i < adj[u].size(); i++) {
                int v = adj[u][i].v;
                int id = adj[u][i].id;

                emark[id] = true;

                if (fr[v]) {
                    fr[v] = false;
                    Q.push(v);
                    d[v] = d[u] + 1;
                }
            }

        }

        memset(cw, 0, sizeof(cw));

        for (int i = 1; i <= n; i++) {
            cw[i] = inf;
        }
        cw[a] = 0;


        for (int i = 1; i <= m; i++) {
            int id = ed[i].id;
            int v = ed[i].v;
            int u = ed[i].u;
            int w = ed[i].w;

            if (emark[id]) {
                if (cw[u] < inf && cw[v] > cw[u] + w) {
                    cw[v] = cw[u] + w;
                }
            }
        }

        int ans;
        if (cw[b] == inf) {
            ans = -1;

        } else {
            ans = cw[b];
        }

        cout << ans << endl;

        //int res;
        
        //fscanf(pFile, "%d", &res);
        //if (ans != res) {
            //cout << n << " " << m << " " << 1 << endl;

            //for (int i = 1; i <= m; i++) {
                //cout << ed[i].u << " " << ed[i].v << " " << ed[i].w << " " << endl;
            //}

            //cout << a << " " << b << " " << c << endl;
        //}


    }
}

int main() {
    freopen("F2.txt", "r", stdin);
    freopen("F2.out", "w", stdout);
    pFile = fopen ("path.out","r");  
    int Test;
    cin >> Test;

    while (Test--) {
        process();
    }

}
