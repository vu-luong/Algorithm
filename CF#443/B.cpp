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

int n;
long long k;
int a[1000];
int dem[1000];
int main() {
//    freopen("B.txt", "r", stdin);
 
    cin >> n >> k;

    int maxa = -1;
    for (int i = 1; i <= n; i++) {
        cin >> a[i];
    }

    int res = 0;

    while (true) {
        res++;

        if (a[1] == n) {cout << a[1]; break; }
        if (a[1] > a[2]) {
            dem[a[1]]++;
            if (dem[a[1]] == k) {cout << a[1]; break;}
            int tmp = a[2];
            for (int i = 2; i <= n - 1; i++) {
                a[i] = a[i + 1];
            }
            a[n] = tmp;
        } else {
            dem[a[2]]++;
            if (dem[a[2]] == k){cout << a[2]; break;}
            int tmp = a[1];
            for (int i = 1; i <= n - 1; i++) {
                a[i] = a[i + 1];
            }
            a[n] = tmp;
        }
    }

}
