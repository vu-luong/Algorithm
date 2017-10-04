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

const int MAXN = (int) 1e5 + 5;
const int oo = (int) 1e9 + 7;
const int base = (int) 1e9 + 7;

int n, m;
int c[MAXN];
vector<int> adj[MAXN];
stack<int> st;
set<int> lt[MAXN];
int low[MAXN], num[MAXN];
bool fr[MAXN];
int res, cnt;


void dfs(int u) {

    cnt++;
    num[u] = cnt;
    low[u] = num[u];
    
    st.push(u);

    for (int i = 0; i < adj[u].size(); i++) {
        int v = adj[u][i];
        if (!fr[v]) continue;

        if (num[v] != 0) low[u] = min(low[u], num[v]);
        else {
            dfs(v);
            low[u] = min(low[u], low[v]);
        }
    }

    if (num[u] == low[u]) {
        res++;
        while (true) {
            int tmp = st.top();
            lt[res].insert(tmp);
            fr[tmp] = false;
            st.pop();
            if (tmp == u) break;
        }
    }

}

int main() {
//    freopen("427_C.txt", "r", stdin);
    
    scanf("%d", &n);
    for (int i = 1; i <= n; i++) {
        scanf("%d", &c[i]);
    }

    scanf("%d", &m);

    for (int i = 1; i <= m; i++) {
        int u, v;
        scanf("%d %d", &u, &v);
        adj[u].push_back(v);
    }
    
    memset(fr, true, sizeof(fr));
    res = 0;
    cnt = 0;

    for (int i = 1; i <= n; i++) {
        if (num[i] == 0) dfs(i);
    }

    long long ans = 0;
    long long n_ans = 1;
    for (int i = 1; i <= res; i++) {
        int min_c = oo;
        for (auto v: lt[i]) {
//            DEBUG(c[v]);
            if (c[v] < min_c) min_c = c[v];
        }
        
        long long num = 0;
        for (auto v: lt[i]) {
            if (c[v] == min_c) num++;
        }
//        DEBUG(min_c);

        ans = ans + min_c;
        n_ans = (n_ans*num) % base;
    }

    cout << ans << " " << n_ans << endl;


}
