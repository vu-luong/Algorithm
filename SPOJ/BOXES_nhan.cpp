#include<bits/stdc++.h>
#define DEBUG(x) cout << #x << " = " << x << endl;
using namespace std;
const int NMAX = 1e3 + 5;
int test, n, a[NMAX];
int distance(int a, int b, int n) {
    return min(abs(a - b), n - abs(a - b));
}
int main() {
    //freopen("input.txt", "r", stdin);
    scanf("%d", &test);
    while (test--) {
        scanf("%d", &n);
        for (int i = 0; i < n; i++) {
            scanf("%d", &a[i]);
        }
        // solve here
        int res = 0;
        while (1) {
            //DEBUG(res);
            bool ok = true;
            for (int i = 0; i < n; i++) {
                if (a[i] > 1) ok = false;
            }
            if (ok) break;
            int h = 0, t = 0, bz = -1, bnz = -1;
            // ccw
            while (t < n) {
                //DEBUG(t);
                if (a[t] == 0 && a[h] <= 1) {
                    h = (h + 1) % n;
                } else if (a[t] == 0 && a[h] > 1) {
                    if (bz == -1 || distance(bz, bnz, n) > distance(t, h, n)) {
                        bz = t; bnz = h;
                    }
                    t++;
                } else {
                    if (t == h) h = (h + 1) % n;
                    t++;
                }
            }
            // cw
            h = n - 1; t = n - 1;
            while (t >= 0) {
                if (a[t] == 0 && a[h] <= 1) {
                    h = (h - 1 + n) % n;
                } else if (a[t] == 0 && a[h] > 1) {
                    if (bz == -1 || distance(bz, bnz, n) > distance(t, h, n)) {
                        bz = t; bnz = h;
                    }
                    t--;
                } else {
                    if (t == h) h = (h - 1 + n) % n;
                    t--;
                }
            }
            res += distance(bz, bnz, n);
            a[bz]++; a[bnz]--;
        }
        printf("%d\n", res);
    }
}


