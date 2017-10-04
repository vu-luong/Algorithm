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
const long long oo = (long long) 1e17 + 7;

struct data {
    int a, b, h;
};

data s[MAXN];
long long f[MAXN];
int n;
long long maxf;
long long tr[MAXN*4];

bool cmp(data x, data y) {
    return ((x.b < y.b) || (x.b == y.b && x.a > y.a));
}

void update(int x, int l, int h, int pos, int val) {
    if (l == h && h == pos) {
        tr[x] = val;
        return;
    }
    
    if (h < pos || l > pos) return;
    
    int mid = (l + h) / 2;
    update(x * 2, l, mid, pos, val);
    update(x * 2 + 1, mid + 1, h, pos, val);
    tr[x] = max(tr[x * 2], tr[x * 2 + 1]);
}

void getmax(int x, int l, int h, int u, int v) {
    if (l > v || h < u) return;
    if (u <= l && h <= v) {
        maxf = max(maxf, tr[x]);
        return;
    }
    
    int mid = (l + h) / 2;
    getmax(x * 2, l, mid, u, v);
    getmax(x * 2 + 1, mid + 1, h, u, v);
}

int main() {
//    freopen("C", "r", stdin);
    
    scanf("%d", &n);
    for (int i = 1; i <= n; i++) {
        scanf("%d %d %d", &s[i].a, &s[i].b, &s[i].h);
    }
    
    sort(s + 1, s + n + 1, cmp);
    
    for (int i = 1; i <= n; i++) {
        cout << s[i].a << " " << s[i].b << " " << s[i].h << endl;
    }
    
    f[1] = s[1].h;
    update(1, 1, n, 1, f[1]);
    
    for (int i = 2; i <= n; i++) {
        int first = 0;
        int last = i;
        while (first + 1 < last) {
            int mid = (first + last) / 2;
            if (s[mid].b > s[i].a) {
                last = mid;
            } else {
                first = mid;
            }
        }
        int id1 = 0;
        if (last != i) {
            id1 = last;
        }
        
        first = 0;
        last = i;
        while (first + 1 < last) {
            int mid = (first + last) / 2;
            if (s[mid].b <= s[i].b) {
                first = mid;
            } else {
                last = mid;
            }
        }
        
        int id2 = 0;
        if (first != 0) {
            id2 = first;
        }
        
        if (id1 != 0 && id2 != 0 && id1 <= id2) {
            maxf = -oo;
            getmax(1, 1, n, id1, id2);
            f[i] = maxf + s[i].h;
        } else {
            f[i] = s[i].h;
        }
        
        update(1, 1, n, i, f[i]);
    }
    
    cout << f[n] << endl;
    
}
