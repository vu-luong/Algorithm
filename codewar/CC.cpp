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

#define PB push_back
#define MP make_pair
#define SZ(a) a.size()
#define DEBUG(x) cout << #x << " = " << x << endl;

#define PR(A,n)  { cout << #A << " = "; for (int i = 1, _n = (n); i <= _n; i++) \
                    cout << A[i] << ' '; cout << endl; }
#define PR0(A,n) { cout << #A << " = "; for (int i = 0, _n = (n); i < _n; i++) \
                    cout << A[i] << ' '; cout << endl; }

using namespace std;

const int MAXN = 22;
int start;

vector<int> adj[MAXN];
int res;
int n, m;
bool fr[MAXN];
int cha[MAXN];

void dfs(int u) {

    for (int i = 0; i < adj[u].size(); i++) {
        int v = adj[u][i];
        if (v != start - 1) {
            if (!fr[v]) {
                if (v == start && cha[u] != start) {
                    res++;
                }
            } else {
                fr[v] = false;
                cha[v] = u;
                dfs(v);
                fr[v] = true;
            }
        
        }
    }

}

int main() {
    freopen("C.txt", "r", stdin);
    freopen("C.out", "w", stdout);
    
    scanf("%d %d", &n, &m);
    
    for (int i = 1; i <= m; i++) {
        int u, v;
        scanf("%d %d", &u, &v);
        adj[u].push_back(u);
        adj[v].push_back(v);
    }

    res = 0;
    for (int i = 1; i <= n; i++) {
        memset(fr, true, sizeof(fr));
        start = i;
        fr[start] = false;
        dfs(start);

    }

}

