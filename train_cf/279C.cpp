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
const int MAXN = (int) 1e5 + 10;

int a[MAXN], l[MAXN], r[MAXN];
int pos[MAXN];
int first[MAXN];
int n, m;

int main() {
    freopen("279C.txt", "r", stdin);
 
    scanf("%d %d", &n, &m);

    for (int i = 1; i <= n; i++) {
        scanf("%d", &a[i]);
    }

    bool up = true;
    l[1] = 1;
    int cnt = 1;
    pos[1] = 1;

    for (int i = 2; i <= n; i++) {
        if (up) {
            if (a[i] >= a[i - 1]) {
                pos[i] = cnt;
            } else {
                pos[i] = cnt;
                first[i] = i;
                up = false;
            }
        } else {
            if (a[i] <= a[i - 1]) {
                if (a[i] == a[i - 1]) {
                    first[i] = first[i - 1];
                } else {
                    first[i] = i;
                }
                pos[i] = cnt;
            } else {
                r[cnt] = i - 1;
                cnt++;
                pos[i] = cnt;
                l[cnt] = first[i - 1];
                up = true;
            }
        }
    }

    r[cnt] = n;


    for (int i = 1; i <= m; i++) {
        int u, v;
        scanf("%d %d", &u, &v);
        int p1 = pos[u];

        if ((l[p1] <= u && v <= r[p1])
            || (l[p1 + 1] <= u && v <= r[p1 + 1]))
            cout << "Yes" << endl;
        else cout << "No" << endl;

    }
}
