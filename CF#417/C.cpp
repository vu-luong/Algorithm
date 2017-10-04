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

const int MAXN = (int) 1e5 + 5;

int n;
long long a[MAXN], b[MAXN];
long long S;


bool check(int k) {
    
    for (int i = 1; i <= n; i++) {
        b[i] = a[i] + 1ll*i*k;
    }

    sort(b + 1, b + n + 1);

    long long t = 0;
    for (int i = 1; i <= k; i++) {
        t += b[i];
    }

    return t <= S;
}

long long cal(int k) {
    for (int i = 1; i <= n; i++) {
        b[i] = a[i] + 1ll*i*k;
    }

    sort(b + 1, b + n + 1);

    long long t = 0;
    for (int i = 1; i <= k; i++) {
        t += b[i];
    }

    return t;
}

int main() {
//    freopen("C.txt", "r", stdin);
    
    cin >> n >> S;

    for (int i = 1; i <= n; i++) {
        cin >> a[i];
    }

    int first = 0;
    int last = n + 1;

    while (first + 1 < last) {
        int mid = (first + last) / 2;

        int sum;

        if (check(mid)) {
            first = mid;
        } else last = mid;
    }

    cout << first << " " << cal(first) << endl;
    

}
