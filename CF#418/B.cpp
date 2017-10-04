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

const int MAXN = 1500;
int a[MAXN], b[MAXN];

int n;
bool mark[MAXN];

int main() {
//    freopen("B.txt", "r", stdin);
    

    cin >> n;
    for (int i = 1; i <= n; i++) {
        cin >> a[i];
    }

    for (int i = 1; i <= n; i++) {
        cin >> b[i];
    }

    memset(mark, false, sizeof(mark));
    int cnt = 0;
    
    for (int i = 1; i <= n; i++) {
        mark[a[i]] = true;
        if (a[i] == b[i]) {
            cnt ++;
            
        }       
    }

    int value = 0;

    for (int i = 1; i <= n; i++) {
        if (!mark[i]) {
            value = i;
            break;
        }
    }


    int da, ca, db, cb;
    for (int i = 1; i <= n - 1; i++) {
        for (int j = i + 1; j <= n; j++) {
            if (a[i] == a[j]) {
                da = i;
                ca = j;
            }
            if (b[i] == b[j]) {
                db = i;
                cb = j;
            }
        }
    }

    for (int i = 1; i <= n; i++) {
        if (a[i] != b[i] && (i == da || i == ca)) {
            a[i] = value;
            break;
        }
    }

    for (int i = 1; i <= n; i++) {
        cout << a[i] << " ";
    }

}
