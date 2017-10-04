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

const int MAXN = (int) 1e5 + 5;


pair<int, int> a[MAXN];
int n;

int main() {
//    freopen("137_C.txt", "r", stdin);
    
    scanf("%d", &n);

    for (int i = 1; i <= n; i++) {
        cin >> a[i].first >> a[i].second;
    }

    int max_a = -1;

    sort(a + 1, a + n + 1);
    int res = 0;
    for (int i = 1; i <= n; i++) {
        if (max_a > a[i].second) {
            res++;
        }
        if (max_a < a[i].second) {
            max_a = a[i].second;
        }
    }

    cout << res;



    

}
