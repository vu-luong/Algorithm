#include <bits/stdc++.h>

#define DEBUG(x) cout << #x << " = " << x << endl;
using namespace std;

long long cal(long long a, long long b) {

    long long t = min(a, b);
    
    long long res = 1;
    long long p1 = 1;
    long long p2 = 1;
    long long p = 1;
    for (int i = 0; i <= t; i++) {
        p1 = p1 * (a - i);
        p2 = p2 * (b - i);
        p = p * (i + 1);

        res += p1*p2/p;
    }

    return res;

}
int main() {
    freopen("C.txt", "r", stdin);
    long long a, b, c;   
    cin >> a >> b >> c;

    cout << cal(a, b) * cal(b, c) * cal(c,a);

}
