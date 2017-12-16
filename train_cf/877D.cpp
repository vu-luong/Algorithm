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

string s;
queue< pair<int, int> > q;
int a[1005][1005];
int n, m, k;
int x1, y1_, x2, y2;
int f[1005][1005];
bool fr[1005][1005];

int main() {
//    freopen("877D.txt", "r", stdin);
 
    cin >> n >> m >> k;

    for (int i = 1; i <= n; i++) {
        cin >> s;
        for (int j = 1; j <= m; j++) {
            a[i][j] = (s[j - 1] == '#');
        }
    }

    cin >> x1 >> y1_ >> x2 >> y2;

    q.push({x1, y1_});
    memset(fr, true, sizeof(fr));
    fr[x1][y1_] = false;
    f[x1][y1_] = 0;

    if (x2 == x1 && y2 == y1_) {
        cout << 0 << endl;
        return 0;
    }

    while (!q.empty()) {
        int u1 = q.front().first;
        int v1 = q.front().second;
//        DEBUG(u1);
//        DEBUG(v1);
        q.pop();

        // di len
        for (int i = u1 - 1; i >= max(1, u1 - k); i--) {
            if (!fr[i][v1]) continue;
            if (a[i][v1] == 1) break;
            q.push({i, v1});
            fr[i][v1] = false;
            f[i][v1] = f[u1][v1] + 1;
        }
        
        // di xuong
        for (int i = u1 + 1; i <= min(u1 + k, n); i++) {
            if (!fr[i][v1]) continue;
            if (a[i][v1] == 1) break;
            q.push({i, v1});
            fr[i][v1] = false;
            f[i][v1] = f[u1][v1] + 1;
        }

        // di trai 
        for (int j = v1 - 1; j >= max(1, v1 - k); j--) {
            if (!fr[u1][j]) continue;
            if (a[u1][j] == 1) break;
            q.push({u1, j});
            fr[u1][j] = false;
            f[u1][j] = f[u1][v1] + 1;
        }
        
        // di phai
        for (int j = v1 + 1; j <= min(m, v1 + k); j++) {
            if (!fr[u1][j]) continue;
            if (a[u1][j] == 1) break;
            q.push({u1, j});
            fr[u1][j] = false;
            f[u1][j] = f[u1][v1] + 1;
        }
        
        if (fr[x2][y2] == false) {
            cout << f[x2][y2] << endl;
            return 0;
        }
    }

    cout << "-1" << endl;
}
