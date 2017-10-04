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

const int MAXN = (int) 1e6 + 5;
const int oo = (int) 1e9 + 7;

int n;
int a[MAXN];
int f[MAXN], g[MAXN];

int main() {
//    freopen("mini_social.txt", "r", stdin);

    scanf("%d", &n);

    for (int i = 1; i <= n; i++) {
        scanf("%d", &a[i]);
    }

    int mina = oo;
    int maxa = -oo;
    long long res = 0;

    for (int i = 1; i <= n; i++) {
        bool ok = false;
        if (a[i] < mina) {
            mina = a[i];
            ok = true;
        }
        if (a[i] > maxa) {
            maxa = a[i];
            ok = true;
        }

        if (!ok) {
            res = res + maxa - mina;
            maxa = a[i];
            mina = a[i];
        }
    }   

    res = res + maxa - mina;

    cout << res << endl;


}
