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

const int MAXN = (int) 5e4 + 5;

int n, m;

int it[MAXN * 8], T[MAXN * 8];

int res;

void update(int x, int l, int r, int u, int v, int value) {

    if (T[x] > 0) {
        it[x] += T[x];
        T[2 * x] += T[x];
        T[2 * x + 1] += T[x];
        T[x] = 0;
    }

    if (r < u || l > v) return;

    if (u <= l && r <= v) {
        it[x] += value;
        T[2 * x] += value;
        T[2 * x + 1] += value;
        T[x] = 0;
        return;
    }

    int mid = (l + r) / 2;
    update(x * 2, l, mid, u, v, value);
    update(x * 2 + 1, mid + 1, r, u, v, value);

    it[x] = max(it[x * 2], it[x * 2 + 1]);
}

void getmax(int x, int l, int r, int u, int v) {

    if (T[x] > 0) {
        it[x] += T[x];
        T[2 * x] += T[x];
        T[2 * x + 1] += T[x];
        T[x] = 0;
    }

    if (r < u || l > v) return;

    if (u <= l && r <= v) {
        if (it[x] > res) res = it[x];
        return;
    }

    int mid = (l + r) / 2;

    getmax(x * 2, l, mid, u, v);
    getmax(x * 2 + 1, mid + 1, r, u, v);
}



int main() {
//    freopen("QMAX2.txt", "r", stdin);
//    freopen("QMAX2.out", "w", stdout);
    
    int num1;
    int num2;
    
    cin >> num1 >> num2;

    cout << num1 + num2 << endl;



}   
