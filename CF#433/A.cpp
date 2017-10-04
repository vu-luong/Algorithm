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

int n, k;


int main() {
    freopen("A.txt", "r", stdin);

    cin >> n >> k;
    
    int mmin;

     if (k == 0) {
        cout << 0 << " " << 0 << endl;
        return 0;
    }
    if (n == 1) {
        mmin = 0;
        cout << 0 << " " << 0 << endl;
        return 0;

    }    else mmin = min(1, n - k);

   

    int mmax;
    int t = (n - 1) / 3;
    if ((n - 1) % 3 != 0) t++;

//    cout << t;
    

    cout << mmin << " ";
//    if (t > k) {
//        cout << 2*k;
//    } else {
//            cout << n - k;
//    }
//

    cout << min(2*k, n - k);


}
