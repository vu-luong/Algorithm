#include <bits/stdc++.h>

using namespace std;

const int MAXN = 200055;

long long a[MAXN], s[MAXN], t[MAXN];
int n, m;
int main() {
    int ntest;
    cin >> ntest;

    while (ntest--) {
        scanf("%d %d", &n, &m);

        memset(s, 0, sizeof(s));
        memset(a, 0, sizeof(a));
        s[0] = 0;
        for (int i = 1; i <= n; i++) {
            scanf("%lld", &a[i]);
            s[i] = s[i - 1] + a[i];
        }
        
        int cnt = 1;
        memset(t, 0, sizeof(t));
        t[1] = 0;
        for (int i = 1; i <= n; i++) {
            if (a[i] == m) {
                cnt ++;
                t[cnt] = i;
            }
        }
        cnt ++;
        t[cnt] = n + 1;

        long long res = 0;
        for (int i = 3; i <= cnt; i++) {
            int r = t[i] - 1;
            int l = t[i - 2] + 1;
            long long sum = s[r] - s[l - 1];
            if (sum > res) res = sum;
        }

        cout << res << endl;
    }


}
