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

const int MAXN = (int) 3e5 + 5;

int n;
int a[MAXN];

bool cmp(int a, int b) {
    return a > b;
}

int main() {
//    freopen("C.txt", "r", stdin);
    
    scanf("%d", &n);

    int t = 2 * n;
    int top = 0;
    int res = 0;
    int cnt = 0;
    while (t--) {
        string s;
        int num;

        cin >> s;

    
        if (s == "add") {
            cin >> num;
            top++;
            a[top] = num;
        } else {
            cnt++;
            if (a[top] != cnt) {
                res++;
                sort(a + 1, a + top + 1, cmp);
                top--;
            } else top--;
        }
    }

    cout << res << endl;
}
