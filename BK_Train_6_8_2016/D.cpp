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
const int MAXN = 1005;
string s;
int m;
int f[MAXN][MAXN];
int c[MAXN];


int main() {
    freopen("D.txt", "r", stdin);

    cin >> s;
    int n = s.length();

    for (int i = 0; i < n; i++) {
        if (s[i] == '(') {
            c[i + 1] = 1;
            m++;
        } else c[i + 1] = -1;
    }


    f[0][0] = 1;
    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= m; j++) {
            f[i][j] = f[i - 1][j];
            if (j >= c[i])
                f[i][j] += f[i - 1][j - c[i]];
                cout << i << " " << j << " " << f[i][j] << endl;
        }
    }

    cout << f[n][0];

}
