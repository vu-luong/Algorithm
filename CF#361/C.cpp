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

using namespace std;

#define PB push_back
#define MP make_pair
#define SZ(a) a.size()
#define DEBUG(x) cout << #x << " = " << x << endl;

#define FOR(i, a, b) for (int _b = (b), i = (a); i <= _b; i++)
#define FORD(i, a, b) for (int _b = (b), i = (a); i >= _b; i--)
#define REP(i, a) for (int i = 0, _a = (a); i < _a; i++)
#define FIT(it, v) for (typeof((v).begin()) it = (v).begin(); it != (v).end(); it++)

using namespace std;

long long m;

long long cal(long long num) {
    long long l = (long long) pow(num, 1.0f/3);
    long long cnt = 0;
    for (long long k = 2; k <= l; k++) {
        long long a = num / (k*k*k);
        if (a >= 1) cnt += a;
    }

    return cnt;

}

int main() {
    // freopen("C.txt", "r", stdin);

    cin >> m;

    long long first = 0;
    long long last = (long long) 1e16;

    while (first + 1 < last) {
        long long mid = (first + last)/2;

        if (cal(mid) >= m) last = mid;
        else first = mid;
    }

    if (cal(last) == m) cout << last << endl;
    else cout << -1 << endl;

}
