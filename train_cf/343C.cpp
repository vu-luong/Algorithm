#include <bits/stdc++.h>

#define PB push_back
#define MP make_pair
#define SZ(a) a.size()
#define DEBUG(x) cout << #x << " = " << x << endl;

#define PR(A,n)  { cout << #A << " = "; for (int i = 1, _n = (n); i <= _n; i++) \
                    cout << A[i] << ' '; cout << endl; }
#define PR0(A,n) { cout << #A << " = "; for (int i = 0, _n = (n); i < _n; i++) \
                    cout << A[i] << ' '; cout << endl; }
typedef long long ll;
using namespace std;
const int MAXN = (int) 1e5 + 5;
int n, m;
ll p[MAXN], h[MAXN];

bool check(ll t) {
    int cp = 1;
    int ch = 1;
    
    while (true) {
        if (t < (abs(h[ch] - p[cp]))) {
            ch++;
            if (ch > n) break;
            continue;
        }
        ll tmp;
        if (h[ch] <= p[cp]) {
            tmp = t;
        } else {
            tmp = max((t - (h[ch] - p[cp])) / 2, t - 2*(h[ch] - p[cp]));
        }
     
        tmp += h[ch];
        while (cp <= m && p[cp] <= tmp) cp++;
        ch++;
        if (ch > n || cp > m) break;
    }
    
    return (cp > m);
}
int main() {
//    freopen("343C.txt", "r", stdin);

    cin >> n >> m;


    for (int i = 1; i <= n; i++) {
        cin >> h[i];
    }
    for (int i = 1; i <= m; i++) {
        cin >> p[i];
    }

    long long first = -1;
    long long last = (long long) 2e10;
    while (first + 1 < last) {
        ll mid = (first + last) / 2;
//        DEBUG(mid);
        if (check(mid)) last = mid;
        else first = mid;
    }

    cout << last << endl;
}
