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
int s[1005];
int d[1005];
int n;
int main() {

//    freopen("A.txt", "r", stdin);
 
    cin >> n;

    int cur = 0;
    for (int i = 1; i <= n; i++) {
        cin >> s[i] >> d[i];
        while (true) {
            cur++;
            if (cur < s[i]) continue;
            if ((cur - s[i]) % d[i] == 0) break;
        }
    }
    
    cout << cur << endl;

}
