#include <bits/stdc++.h>
#define DEBUG(x) cout << #x << " = " << x << endl;
#define DEBUGA(a, b) cout << "[ "; for (auto x = (a); x != (b); x++) cout << *x << " ";\
    cout << "]" << endl
#define _1 first
#define _2 second

using namespace std;

long long pre_res[1005];
long long str[100];
// x = str[from..to];
long long f(long long x, int from, int to) {
    if (x == 0) return 0;
    /* DEBUGA(str + from, str + to + 1); */
    if (from > to) return 0;
    long long tail_res = f(x - str[from] * pow(10ll, to - from), from + 1, to);
    long long res = 0;

    res += tail_res;
    /* DEBUG(tail_res); */
    if (str[from] > 8) {
        res += 2ll * pow(10ll, to - from);
    } else if (str[from] == 8) {
        res += 1ll* (x - str[from] * pow(10ll, to - from) + 1);
        res += 1ll * pow(10ll, to - from);
    } else if (str[from] == 7) {
        res += 1ll * pow(10ll, to - from);
    } else if (str[from] == 6) {
        res += 1ll * (x - str[from] * pow(10ll, to - from) + 1);
    }

    res += 1ll * (to - from) * 2 * pow(10ll, max(0, to - from - 1)) * (str[from]);
    /* DEBUG(res); */
    /* if (res == 34) res++; */
    return res;
}

long long brute_force(long long x) {
    /* DEBUG(x); */
    long long cnt = 0;
    for (int i = 1; i <= x; i ++) {
        if (i % 8 == 0 || i == x) {
            int k = i;
            while (k) {
                if (k % 10 == 6 || k % 10 == 8) cnt++;
                k = k / 10;
            }
        }
    }
    return cnt;
}

int main(){
    freopen("C.txt", "r", stdin); 
    int t; cin >> t;
    long long cnt = 0;
    for (int i = 1; i <= 1000; i ++) {
        if (i % 8 == 0) {
            int k = i;
            while (k) {
                if (k % 10 == 6 || k % 10 == 8) cnt++;
                k = k / 10;
            }
        }
        pre_res[i] = cnt;
    }
    while (t--) {
        long long n; cin >> n;
        long long res;
        if (n < 1000) {
            res = pre_res[n];
        } else {
            string s = to_string(n / 1000 - 1);
            for (int i = 0; i < s.size(); i++) {
                str[i] = s[i] - '0';
            }
            /* DEBUG(brute_force(87)); */
            /* DEBUG(s); */
            res = 1ll * f(n / 1000 - 1, 0, s.size() - 1) * 125 + 1ll * n / 1000 * pre_res[1000];
            /* DEBUG(res); */
            /* DEBUG(brute_force((n / 1000) * 1000 - 1)); */

            // truoc
            res += pre_res[n % 1000];
            long long m = n / 1000;
            long long cnt = 0;
            while (m) {
                if (m % 10 == 8 || m % 10 == 6)  {
                    cnt++;
                }
                m = m / 10;
            }
            res += 1ll * cnt * ((n % 1000) / 8 + 1);
        }
        if (n % 8 != 0) {
            long long m = n;
            while (m) {
                if (m % 10 == 8 || m % 10 == 6)  {
                    res++;
                }
                m = m / 10;
            }
        }
        //long long b_res = brute_force(n);
        //DEBUG(b_res);
        cout << res << endl;
    }
}

