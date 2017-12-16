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
const long long oo = (long long) 1e17 + 7;
int a[MAXN][MAXN];
int x[MAXN];
vector<int> s;
long long d[MAXN];
priority_queue< pair<long long, int> > q;
int n;
bool fr[MAXN];
long long res;
long long dis[MAXN][MAXN];

void reset() {
    for (auto u : s) {
        fr[u] = true;
        d[u] = oo;
    }
    q = priority_queue< pair<long long, int> > ();
}
void dij(int st) {
    reset();
    q.push({0, st});
    fr[st] = false;
    d[st] = 0;
    
    while (!q.empty()) {
        int u = q.top().second;
        q.pop();
        fr[u] = false;
    
        for (int i = 0; i < s.size(); i++) {
            int v = s[i];
            if (v == u) continue;
            if (!fr[v]) continue;

            if (d[v] > d[u] + a[u][v]) {
                d[v] = d[u] + a[u][v];
                q.push({-d[v], v});
            }
        }
    }

    for (int i = 0; i < s.size(); i++) {
        int v = s[i];
        res += d[v];
        dis[st][v] = d[v];
    }
}

void rev_dij(int st) {
    reset();
    q.push({0, st});
    fr[st] = false;
    d[st] = 0;
    
    while (!q.empty()) {
        int u = q.top().second;
        q.pop();
        fr[u] = false;
    
        for (int i = 0; i < s.size(); i++) {
            int v = s[i];
            if (v == u) continue;
            if (!fr[v]) continue;

            if (d[v] > d[u] + a[v][u]) {
                d[v] = d[u] + a[v][u];
                q.push({-d[v], v});
            }
        }
    }

    for (int i = 0; i < s.size(); i++) {
        int v = s[i];
        res += d[v];
        dis[v][st] = d[v];
    }
}

void fix(int st) {
//    DEBUG(res);
    for (int i = 0; i < s.size() - 1; i++) {
        for (int j = i + 1; j < s.size(); j++) {
            int u = s[i];
            int v = s[j];
            if (dis[u][v] > dis[u][st] + dis[st][v]) {
                dis[u][v] = dis[u][st] + dis[st][v];
            }
            if (dis[v][u] > dis[v][st] + dis[st][u]) {
                dis[v][u] = dis[v][st] + dis[st][u];
            }

            res += dis[u][v] + dis[v][u];
//            DEBUG(dis[u][v]);
//            DEBUG(dis[v][u]);
        }
    }

}

int main() {
//    freopen("295B.txt", "r", stdin);

    cin >> n;

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            scanf("%d", &a[i][j]);
        }
    }

    for (int i = 1; i <= n; i++) {
        cin >> x[i];
    }

    s.PB(x[n]);
    memset(dis, 0, sizeof(dis));
    long long sa[MAXN];
    sa[n] = 0;
    for (int i = n - 1; i >= 1; i--) {
        res = 0;
        dij(x[i]);
        rev_dij(x[i]);
        fix(x[i]);
        s.PB(x[i]);
        sa[i] = res;
    }

    for (int i = 1; i <= n; i++) {
        cout << sa[i] << " ";
    }
}

