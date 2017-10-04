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
const int MAXN = (int) 1e6 + 100;

int n;
int f[MAXN];
int max_s;
pair<int, int> s[MAXN];
// vector<int> a;

int main() {
    freopen("C.txt", "w", stdout);
    cout << 1000000 << endl;

    for (int i = 1; i <= 1000000; i++) {
        int u = rand() % 1000000 + 1;
        int v = rand() % 1000000 + 1;
        cout << u << " " <<v << endl;
    }

}
