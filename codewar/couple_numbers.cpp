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

long long m, n;

string tobin(long long num) {
    
    string res = "";

    while (true) {
        int cs = num % 2;
        char c = cs + 48;
        res = c + res;
        num = num / 2;
        if (num == 0) break;
    }

    return res;

}

int main() {
//    freopen("couple_numbers.txt", "r", stdin);
    
    cin >> m >> n;

    string s1 = tobin(m - n);
    string s2 = tobin(n);

    while (s1.length() < s2.length()) s1 = "0" + s1;
    while (s2.length() < s1.length()) s2 = "0" + s2;
    
    DEBUG(s1);
    DEBUG(s2);

    cout << tobin(4) << endl;

    if (m < n) {
        cout << 0 << endl;
        return 0;
    }

    long long res = 1;
    for (int i = s1.length() - 1; i >= 0; i--) {
        if (s1[i] == '0' && s2[i] == '0') 
            res *= 1;

        if (s1[i] == '0' && s2[i] == '1') 
            res *= 2;

        if (s1[i] == '1' && s2[i] == '0')
            res *= 1;

        if (s1[i] == '1' && s2[i] == '1')
            res *= 0;
    }

    if (m == n) res -= 2;

    cout << res << endl;

}
