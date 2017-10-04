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

string s;

int modInv(int a, int m) {

    int xa = 1;
    int xm = 0;

    while (m != 0) {
        int q = a / m;
        int xr = xa - q * xm;
        xa = xm;
        xm = xr;
        int r = a % m;
        a = m;
        m = r;
    }
    return xa;

}

int main() {
    
    cout << modInv(25, 101);
    
}

