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

int a[MAXN];
int n;

int main() {
//    freopen("C.txt", "r", stdin);
    
    scanf("%d", &n);

    for (int i = 1; i <= n; i++) {
        scanf("%d", &a[i]);
    }
    
    sort(a + 1, a + 1 + n);

    int first = 1;
    int last = 1;
    int res = 1;

    while (true) {
        last++;
        if (last == n + 1) break;

        while (a[last] - a[first] > 2)
            first++;

        if (last - first + 1 > res) 
            res = last - first + 1;
    }

    cout << res;

}
