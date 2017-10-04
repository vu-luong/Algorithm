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
const int MOD = (int) 1e9 + 7;

int test;
int n;
int main() {
    
    freopen("sumpro.txt", "r", stdin);
    scanf("%d", &test);
    
//    cout << test << endl;
    
    while (test--) {
        
        scanf("%d", &n);
        
        long long res = 0;
        for (int i = 1; i <= trunc(sqrt(n)); i++) {
            int x1 = n / (i + 1) + 1;
            int x2 = n / i;
                
            if (x1 <= x2) {
                int r = n / i;
                long long sum = r * i;
                
                res = (res + sum) % MOD;
                
                if (i != r) {
                    int m = x2 - x1 + 1;
                    sum = 1ll*(x2 + x1) * m / 2;
                    res = (res + sum*i) % MOD;
                }
            }
        }
        cout << res << endl;
    }


}

