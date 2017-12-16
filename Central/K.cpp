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

long long n, m;
int main() {
    //freopen("K.txt", "r", stdin);

    cin >> n >> m;

    long long t1 = 2*n - m;
    long long t2 = m - n;

    if (t1 < 0 || t2 < 0 || t1 % 2 == 1 || t2 % 2 == 1) {
        cout << "IMPOSSIBLE" << endl;
        return 0;
    }

    cout << t2 / 2 << " " << t1 / 2;
    

}
