#include <iostream>
#include <cstdio>
#include <cstring>
#include <algorithm>
using namespace std;

const int MAXN = 20, MAXK = MAXN;

typedef long long int64;

int64 c[MAXN][MAXK][10][2][2], a, b;
int v[MAXN], n, d, k;

int64 Cal(int u_i, int u_k, int u_s, bool u_ok, bool u_zero) {
    int64 &res = c[u_i][u_k][u_s][u_ok][u_zero];
    if (res != -1) return res;

    if (u_k > k) res = 0;
    else if (u_i > n) res = 1;
    else {
        res = 0;
        for (int j = 0; j <= max(v[u_i], u_ok * 9); j++) {
            int v_i, v_k, v_s, v_ok, v_zero;

            v_i    = u_i + 1;
            v_k    = u_k + (u_zero ? 0 : (int)(abs(j - u_s) <= d));
            v_s    = j;
            v_ok   = u_ok || (j < v[u_i]);
            v_zero = u_zero && (j == 0);

            res += Cal(v_i, v_k, v_s, v_ok, v_zero);
        }
    }

    return res;
}

int64 Solve(int64 b) {
    n = 0;
    while (b > 0) {
        v[++n] = b % 10;
        b /= 10;
    }
    reverse(v + 1, v + n + 1);

    memset(c, -1, sizeof(c));
    return Cal(1, 0, 0, 0, 1);
}

int main() {
    cin >> a >> b >> d >> k;
    cout << Solve(b) - Solve(a - 1);
}
