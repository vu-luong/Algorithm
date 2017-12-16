#include <bits/stdc++.h>

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
int fa[50005];
int main() {
//    freopen("877B.txt", "r", stdin);
    cin >> s;
    int n = s.length();
    s = " " + s;

    fa[0] = 0;
    for (int i = 1; i <= n; i++) {
       fa[i] = fa[i - 1] + (s[i] == 'a');
    }

    int res = (int) 1e9 + 7;
    for (int i = 1; i <= n + 1; i++) {
        for (int j = i; j <= n + 1; j++) {
            int la = i - 1;
            int mb = j - i;
            int ra = n - j + 1;
            
            int t1 = fa[i - 1];
            int t2 = (j - i) - (fa[j - 1] - fa[i - 1]);
            int t3 = fa[n] - fa[j - 1];

            int temp = (la - t1) + (mb - t2) + (ra - t3);
            if (temp < res) res = temp;
        }
    }

    cout << n - res << endl;
}
