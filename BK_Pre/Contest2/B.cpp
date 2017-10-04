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

const int MAXN = 55;
const int oo = (int) 1e9 + 7;

int v[MAXN], c[MAXN];
long long f[5001][55];
int s, n;
int save[5001];

int main() {
    //freopen("B.txt", "r", stdin);

    int test;
    cin >> test;

    for (int te = 1; te <= test; te++) {
        cin >> s >> n;

        memset(v, 0, sizeof(v));
        memset(c, 0, sizeof(c));
        for (int i = 1; i <= n; i++) {
            cin >> v[i] >> c[i];
        }


        int nsave = 0;
        memset(save, 0, sizeof(save));
        for (int i = 1; i <= s; i++) {
            if (s % i == 0) {
                nsave++;
                save[nsave] = i;
            }
        }


        long long res = 0;
        for (int r = 1; r <= nsave; r++) {
            int k = save[r];
            int sum = s / k;
            memset(f, 0, sizeof(f));
            for (int i = 0; i <= n; i++) {
                f[0][i] = 1;
            }
            for (int x = 1; x <= sum; x++) {
                for (int i = 1; i <= n; i++) {
                    f[x][i] += f[x][i - 1];
                    if (c[i] >= k && v[i] <= x && f[x - v[i]][i - 1] != 0) {
                        f[x][i] += f[x - v[i]][i - 1];
                    }
                }
            }
            res += f[sum][n];
        }


        cout << "Case " << te << ": " << res << endl;


    }
}
