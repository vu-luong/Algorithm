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

long long a, b;

int main() {
    
    cin >> a >> b;

    long long x = trunc(sqrt(1ll*4*a) - 1);
    long long y = trunc(sqrt(1ll*4*b + 1) - 1);

    if (x % 2 == 0) x -= 1;
    if (y % 2 == 1) y -= 1;


    if (x > y) cout << "Valera";
    else cout << "Vladik";

}
