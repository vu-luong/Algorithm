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

int josephus(int n, int k) {
  if (n == 1)
    return 1;
  else
    return (josephus(n - 1, k) + k-1) % n + 1;
}

int n, m;

int main() {
    // freopen("E.txt", "r", stdin);
    int T;
    cin >> T;
    for (int test = 1; test <= T; test++ ){
        scanf("%d %d", &n, &m);
        // p = 1ll * n * m;
        // while (p > n)
        //     p = p + (p - n - 1) / (m - 1) - n;
        // printf("%lld\n", p);
        int res = josephus(n,m);
        printf("%d\n", res);
    }

}
