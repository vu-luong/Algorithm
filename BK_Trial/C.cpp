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

const int MAXM = 105;

struct data {
    int s, p, w;
};

data s[MAXM];
int m, n;
int Test;

int main() {
    freopen("C.txt", "r", stdin);

    cin >> Test;
    while (Test--) {

        scanf("%d %d", &n, &m);

        for (int i = 1; i <= m; i++) {
            scanf("%d %d %d", &s[i].s, &s[i].p, &s[i].w);
        }

        for (int i = 1; i <= m - 1; i++) {
            for (int j = i + 1; j <= m; j++) {
                if (s[i].p + s[i].w > s[j].p + s[j].w ||
                    (s[i].p + s[i].w == s[j].p + s[j].w && s[i].p > s[j].p)) {
                        data temp = s[i];
                        s[i] = s[j];
                        s[j] = temp;
                    }
            }
        }

        for (int i = 1; i <= m; i++) {
            cout << s[i].s << " " << s[i].p << " " << s[i].w << ": " << s[i].p + s[i].w << endl;
        }

    }

}
