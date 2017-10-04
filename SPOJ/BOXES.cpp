#include <map>
#include <set>
#include <cmath>
#include <cstdio>
#include <vector>
#include <string>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <algorithm>
#include <queue>


#define PB push_back
#define MP make_pair
#define SZ(a) a.size()
#define DEBUG(x) cout << #x << " = " << x << endl;

#define PR(A,n)  { cout << #A << " = "; for (int i = 1, _n = (n); i <= _n; i++) \
                    cout << A[i] << ' '; cout << endl; }
#define PR0(A,n) { cout << #A << " = "; for (int i = 0, _n = (n); i < _n; i++) \
                    cout << A[i] << ' '; cout << endl; }

using namespace std;

const int MAXN = 1005;
const int oo = (int) 1e9 + 7;

int n, a[MAXN];
int n0, cnt, pos[MAXN];
int k;
queue<int> q;
int c[MAXN][MAXN];
int Fx[MAXN], Fy[MAXN], matchX[MAXN], matchY[MAXN];
int trace[MAXN], d[MAXN], arg[MAXN];
int start, finish;

int distance(int a, int b) {
    return min(abs(a - b), n - abs(a - b));
}

void process() {

    scanf("%d", &n);

    n0 = 0;
    for (int i = 1; i <= n; i++) {
        scanf("%d", &a[i]);

        if (a[i] == 0) {
            n0++;
            pos[n0] = i;
        }
    }

    for (int i = 1; i <= 1000; i++) {
        for (int j = 1; j <= 1000; j++) {
            c[i][j] = oo;
        }
    }

    cnt = 0;

    for (int i = 1; i <= n; i++) {
        if (a[i] > 1) {
            int t = a[i] - 1;
            while (t--) {
                cnt++;
                for (int j = 1; j <= n0; j++) {
                    c[cnt][j] = distance(i, pos[j]);
                }
            }
        }
    }

    k = n0;
}

void init() {
    memset(matchX, 0, sizeof(matchX));
    memset(matchY, 0, sizeof(matchY));
    memset(Fx, 0, sizeof(Fx));
    memset(Fy, 0, sizeof(Fy));
}

int getC(int i, int j) {
    return c[i][j] - Fx[i] - Fy[j];
}

void initBFS() {
    q = queue<int>();
    q.push(start);

    memset(trace, 0, sizeof(trace));
    for (int j = 1; j <= k; j++) {
        d[j] = getC(start, j);
        arg[j] = start;
    }
    finish = 0;
}

void findAugmentingPath() {

    while (!q.empty()) {
        int i = q.front(); q.pop();
        for (int j = 1; j <= k; j++) {
            if (trace[k] == 0) {
                int w = getC(i, j);
                if (w == 0) {
                    trace[j] = i;
                    if (matchY[j] == 0) {
                        finish = j;
                        return;
                    }
                    q.push(matchY[j]);
                }
                if (d[j] > w) {
                    d[j] = w;
                    arg[j] = i;
                }
            }
        }

    }
}

void subX_addY() {
    int delta = oo;
    for (int j = 1; j <= k; j++) {
        if (trace[j] == 0 && d[j] < delta)
            delta = d[j];
    }

    Fx[start] += delta;
    for (int j = 1; j <= k; j++) {
        if (trace[j] != 0) {
            int i = matchY[j];
            Fy[j] -= delta;
            Fx[i] += delta;
        } else {
            d[j] -= delta;
        }
    }

    for (int j = 1; j <= k; j++) {
        if (trace[j] == 0 && d[j] == 0) {
            trace[j] = arg[j];
            if (matchY[j] == 0) {
                finish = j;
                return;
            }
            q.push(matchY[j]);
        }
    }
}

void Enlarge() {
    while (true) {
        int i = trace[finish];
        int next = matchX[i];
        matchX[i] = finish;
        matchY[finish] = i;
        finish = next;
        if (finish == 0) break;
    }
}

void solve() {
    
    for (int i = 1; i <= k; i++) {
        start = i;
        initBFS();
        while (true) {
            findAugmentingPath();
            if (finish == 0) subX_addY();
            if (finish != 0) break;
        }
        Enlarge();
    }

    DEBUG("den day roi");

    int W = 0;
    int Count = 0;

    for (int i = 1; i <= cnt; i++) {
        int j = matchX[i];
        if (c[i][j] < oo) {
            Count++;
            W += c[i][j];
        }
    }

    cout << W << endl;

}

int main() {
    freopen("BOXES.txt", "r", stdin);

    int test;
    cin >> test;

    while (test--) {
        process();
        init();
        solve();
    }

}
