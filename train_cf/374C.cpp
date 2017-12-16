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

const int MAXN = 1005;
const int dx[] = {0, 0, -1, 1};
const int dy[] = {-1, 1, 0, 0};
int n, m;
int a[MAXN][MAXN];
string s;
bool finish = false;
int cnt = 0;
int ans = 0;
int f[MAXN][MAXN];
bool fr[MAXN][MAXN];

void dfs(int u, int v) {
    if (finish) return;

    f[u][v] = 1;
    for (int i = 0; i < 4; i++) {
        int uu = u + dx[i];
        int vv = v + dy[i];
        int nextval = (a[u][v] + 1) % 4;

        if (uu < 1 || uu > n) continue;
        if (vv < 1 || vv > m) continue;
        if (a[uu][vv] != nextval) continue;

        if (f[uu][vv] == 0) {
            fr[uu][vv] = false;
            dfs(uu, vv);
            fr[uu][vv] = true;
            f[u][v] = max(f[u][v], f[uu][vv] + 1);
        } else {
            if (fr[uu][vv] == false)  {
                if (finish) return;
                finish = true;
                cout << "Poor Inna!" << endl;
                return;
            } else {
                f[u][v] = max(f[u][v], f[uu][vv] + 1);
            }
        }

    }
}
int main() { 
    //freopen("374C.txt", "r", stdin);
    cin >> n >> m;
    for (int i = 1; i <= n; i++) {
        cin >> s;
        for (int j = 1; j <= m; j++) {
            char c = s[j - 1];
            if (c == 'D') a[i][j] = 0;
            if (c == 'I') a[i][j] = 1;
            if (c == 'M') a[i][j] = 2;
            if (c == 'A') a[i][j] = 3;
        }
    }
    
    memset(fr, true, sizeof(fr));
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            cnt ++;
            if (f[i][j] == 0 && a[i][j] == 0) {
                fr[i][j] = false;
                dfs(i, j);
                fr[i][j] = true;
                if (finish) return 0;
                if (f[i][j]/4 > ans) {
                    ans = f[i][j] / 4;
                }

            }
        }
    }
    
    if (!finish) {
        if (ans == 0) cout << "Poor Dima!" << endl;
        else cout << ans << endl;
    }
}
