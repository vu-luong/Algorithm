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
int m, n;

int main() {
    // freopen("D.txt", "r", stdin);

    scanf("%d %d", &m, &n);

    for (int i = 1; i <= m; i++) {
        cin >> s;
    }

    s = '.' + s;

    int res = 0;

    for (int i = 1; i < s.length(); i++) {
        if (s[i] == 'B' && s[i - 1] == '.') {
            res ++;
        }
    }

    cout << res;

}
