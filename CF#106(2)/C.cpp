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
pair<int, int> a[MAXN];

int main() {
    // freopen("C.txt", "r", stdin);

    scanf("%d", &n);
    int sum = 0;
    int max_a = -1;

    for (int i = 1; i <= n; i++) {
        scanf("%d", &a[i].first);
        a[i].second = i;
        sum += a[i].first;
        if (a[i].first > max_a) max_a = a[i].first;
    }

    sort(a + 1, a + n + 1);

    int s1 = 0;
    int s2 = 0;

    int n1 = 0;
    int n2 = 0;
    int p1[MAXN], p2[MAXN];

    for (int i = n; i >= 1; i--) {
        int j = n - i + 1;
        if (j % 4 == 0 || j % 4 == 1) {
            s1 += a[i].first;
            n1++;
            p1[n1] = a[i].second;
        } else {
            s2 += a[i].first;
            n2++;
            p2[n2] = a[i].second;
        }
    }

    cout << n1 << endl;
    for (int i = 1; i <= n1; i++) {
        cout << p1[i] << " ";
    }

    cout << endl;
    cout << n2 << endl;
    for (int i = 1; i <= n2; i++) {
        cout << p2[i] << " ";
    }

    cout << endl;
    // DEBUG(s2 - s1);
    // DEBUG(max_a);

}
