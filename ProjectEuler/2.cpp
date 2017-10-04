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

int main() {
    freopen("2.txt", "r", stdin);

    long long res = 2;

    int x = 1;
    int y = 2;

    while (true) {

        int z = x + y;
        // DEBUG(z);
        if (z >= 4000000) break;
        else if (z % 2 == 0) res = res + z;
        x = y;
        y = z;
    }

    DEBUG(res);

}
