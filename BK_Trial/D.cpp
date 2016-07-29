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

int n;

int main() {
    // freopen("D.txt", "r", stdin);

    cin >> n;

    if (n == 1) cout << 1;
    if (n == 2) cout << 2;
    if (n == 3) cout << 6;
    if (n == 4) cout << 6;
    if (n == 5) cout << 3;
    if (n >= 6) cout << 9;

}
