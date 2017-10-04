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

long long pow10(int l) {
    long long res = 1;
    for (int i = 1; i <= l; i++) {
        res *= 10;
    }
    return res;
}

long long n;

int main() {
//    freopen("A.txt", "r", stdin);
    
    cin >> n;
    s = to_string(n);

    int n1 = s[0] - '0';

    if (n1 < 9) {
        n1 += 1;
        cout << n1 * pow10(s.length() - 1) - n;
    } else {
        cout << pow10(s.length()) - n;
    }

    

}
