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
const int MAXN = 1555;

int n, q, m;
string s;
int f[MAXN][30];

int cal(int m, int c) {

    int dau = 1;
    int sum = 0;
    int res = 0;

    for (int i = 1; i <= n; i++) {
        int num = s[i - 1] - 'a' + 1;
        if (num != c) sum += 1;

//        DEBUG(i);
//        DEBUG(sum);
        
        while (true) {
            if (sum <= m) break;
            int ndau = s[dau - 1] - 'a' + 1;
            if (ndau != c) sum -= 1;
            dau++;
        }
//        DEBUG(dau);

        if ((i - dau + 1) > res) res = i - dau + 1;
    }
    return res;
}

int main() {
//    freopen("C.txt", "r", stdin);
    
    cin >> n;
//    DEBUG(n);
    cin >> s;

    cin >> q;

    for (int c = 1; c <= 26; c++) {
        for (int i = 1; i <= n; i++) {
            f[i][c] = cal(i, c);
        }
    }

    
//    cout << cal(1, 'o' - 'a' + 1) << endl;

    
    for (int i = 1; i <= q; i++) {
        char cha;
        cin >> m >> cha;
        int num = cha - 'a' + 1;

        if (m > n) m = n;

        cout << f[m][num] << endl;
    }
    

}
