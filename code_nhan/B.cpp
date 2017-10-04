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

#define DEBUG(x) cout << #x << " = " << x << endl;
#define PR(A,n)  { cout << #A << " = "; for (int iter = 1, _n = (n); iter <= _n; iter++) \
    cout << A[iter] << ' '; cout << endl; }
#define PR0(A,n) { cout << #A << " = "; for (int iter = 0, _n = (n); iter < _n; iter++) \
    cout << A[iter] << ' '; cout << endl; } 
#define _1 first
#define _2 second

using namespace std;
const int NMAX = 1e4 + 5;
int n, m, p[NMAX], l, r, x;
vector<int> t[2 * NMAX];

void build(int node, int l, int r) {
    if (l == r) {
        t[node] = {p[l]};
    } else {
        int m = (l + r) / 2;
        build(2 * node, l, m);
        build(2 * node + 1, m + 1, r);
        t[node].insert(t[node].end(), t[node * 2].begin(), t[node * 2].end());
        t[node].insert(t[node].end(), t[node * 2 + 1].begin(), t[node * 2 + 1].end());
        sort(t[node].begin(), t[node].end());
    }
}

int query(int node, int l, int r, int ql, int qr, int x) {
    if (ql > r || qr < l) return 0;
    if (ql <= l && r <= qr) {
        return lower_bound(t[node].begin(), t[node].end(), x) - t[node].begin();
    }

    int m = (l + r) / 2;
    int lrs = query(node * 2, l, m, ql, qr, x);
    int rrs = query(node * 2 + 1, m + 1, r, ql, qr, x);
    return lrs + rrs;
}

int main(){
    freopen("input.txt", "r", stdin);
    freopen("output.txt", "w", stdout);
    scanf("%d %d", &n, &m);
    for (int i = 0; i < n; i++) {
        scanf("%d", &p[i]);
    }
    build(1, 0, n - 1);

    while (m--) {
        scanf("%d %d %d", &l, &r, &x);
        int nl = query(1, 0, n - 1, l - 1, r - 1, p[x - 1]);
        if (nl != x - l) {
            printf("%s\n", "NO");
        } else {
            printf("%s\n", "YES");
        }
    }
}
