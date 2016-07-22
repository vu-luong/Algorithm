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
const int MAXN = (int) 2e5 + 5;
const int INF = (int) 1e9 + 7;

int n;
int a[MAXN], b[MAXN];
vector<int> lt[MAXN];
int cnt;
int root, d;
int dd[MAXN];

void visit(int u) {
    dd[u] = d;

    if (dd[a[u]] == d && u != root) {
        if (root == 0) root = u;
        b[u] = root;
        cnt++;
        // DEBUG(u);
    } else if (dd[a[u]] == 0) {
        visit(a[u]);
    }

}

int main() {
    // freopen("D.txt", "r", stdin);

    scanf("%d", &n);
    for (int i = 1; i <= n; i++) {
        scanf("%d", &a[i]);
        b[i] = a[i];
    }

    cnt = 0;
    root = 0;
    memset(dd, 0, sizeof(dd));

    for (int i = 1; i <= n; i++) {
        if (a[i] == i) {
            root = i;
            break;
        }
    }

    d = 0;
    for (int i = 1; i <= n; i++) {
        if (dd[i] == 0) {
            d++;
            visit(i);
        }
    }
    // DEBUG(cnt);
    cout << cnt << endl;

    for (int i = 1; i <= n; i++) {
        cout << b[i] << " ";
    }

}
