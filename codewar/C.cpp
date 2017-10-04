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

const int MAXN = (int) 5e3 + 5;

int a[MAXN];
double x[MAXN];
int f[MAXN][MAXN];
int maxs[MAXN][MAXN], mins[MAXN][MAXN];
int n, m;

int main() {
    //    freopen("C.txt", "r", stdin);
    
    scanf("%d %d", &n, &m);
    for (int i = 1; i <= n; i++) {
        scanf("%d %lf", &a[i], &x[i]);
    }
    
    for (int i = 1; i <= n; i++) {
        maxs[i][i] = a[i];
        mins[i][i] = a[i];
        for (int j = i + 1; j <= n; j++) {
            maxs[i][j] = max(maxs[i][j - 1], a[j]);
            mins[i][j] = min(mins[i][j - 1], a[j]);
        }
    }
    
    for (int i = 1; i <= n; i++) {
        f[i][i] = 0;
    }
    
    for (int k = 1; k <= n - 1; k++) {
        for (int i = 1; i <= n - k; i++) {
            int j = i + k;
            int t = 0;
            if (a[j] >= maxs[i][j - 1]) t = f[i][j - 1];
            else t = f[i][j - 1] + 1;
            
            int r = 0;
            if (a[i] <= mins[i + 1][j]) r = f[i + 1][j];
            else r = f[i + 1][j] + 1;
            
            f[i][j] = min(t, r);
        }
    }
    cout << f[1][n] << endl;

    
    
}

