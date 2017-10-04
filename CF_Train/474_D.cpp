#include <bits/stdc++.h>

using namespace std;

const int MAXN  = (int) 1e5 + 5;
const long long base = (long long) 1e9 + 7;

long long a[MAXN], b[MAXN];
long long max_val;
long long nr[MAXN];
long long sum[MAXN];
int k, t;

int main() {
//    freopen("474_D.txt", "r", stdin);
    
    cin >> t >> k;

    max_val = 0;

    for (int test = 1; test <= t; test++) {
        cin >> a[test] >> b[test];
        max_val = max(max_val, b[test]);
    }

    nr[0] = 1;

    sum[0] = 0;
    for (int i = 1; i <= max_val; i++) {
        if (i >= k) nr[i] = (nr[i - 1] + nr[i - k]) % base;
        else nr[i] = 1;

        sum[i] = (sum[i - 1] + nr[i]) % base;
    }

    for (int test = 1; test <= t; test++) {
        cout << (sum[b[test]] - sum[a[test] - 1] + base) % base << endl;
    }

}
