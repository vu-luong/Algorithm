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
const int MAXN = 55;
int n;
string s;
int a[MAXN][MAXN], b[MAXN][MAXN];
int fx, fy, lx, ly;

void initFirst() {
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            if (a[i][j] == 4) {
                fx = i;
                fy = j;
                return;
            }
        }
    }
}

void initLast() {
    for (int i = n; i >= 1; i--) {
        for (int j = n; j >= 1; j--) {
            if (a[i][j] == 4) {
                lx = i;
                ly = j;
                return;
            }
        }
    }
}

void No() {
    cout << "No" << endl;
    exit(0);
}

int main() {
    // freopen("B.txt", "r", stdin);

    cin >> n;

    for (int i = 1; i <= n; i++) {
        cin >> s;
        for (int j = 0; j < s.length(); j++) {
            a[i][j + 1] = s[j] - '0';
        }
    }

    initFirst();
    initLast();

    if (ly < fy || lx < fx) {
        No();
    }

    memset(b, 0, sizeof(b));

    for (int i = fx; i <= lx; i++) {
        for (int j = fy; j <= ly; j++) {
            b[i][j] = 4;
        }
    }

    if (fx >= 2) {

        if (fy >= 2) b[fx - 1][fy - 1] = 1;
        if (ly <= n - 1) b[fx - 1][ly + 1] = 1;
        for (int i = fy; i <= ly; i++) b[fx - 1][i] = 2;
    }

    if (lx <= n - 1) {
        if (fy >= 2) b[lx + 1][fy - 1] = 1;
        if (ly <= n - 1) b[lx + 1][ly + 1] = 1;
        for (int i = fy; i <= ly; i++) b[lx + 1][i] = 2;
    }

    if (ly >= 2) {
        for (int i = fx; i <= lx; i++) b[i][fy - 1] = 2;
    }

    if (fy <= n - 1) {
        for (int i = fx; i <= lx; i++) {
            b[i][ly + 1] = 2;
        }
    }

    // for (int i = 1; i <= n; i++) {
    //     for (int j = 1; j <= n; j++) {
    //         cout <<b[i][j] << " ";
    //     }
    //     cout << endl;
    // }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            if (a[i][j] != b[i][j])
                No();
        }
    }

    cout << "Yes" << endl;

}
