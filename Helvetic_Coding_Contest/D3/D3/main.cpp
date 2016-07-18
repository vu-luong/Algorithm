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
const int MOD = (int) 1e6 + 3;

int C, W, H;

struct Matrix {
    int a[201][201];
    int n;
} A, T;

Matrix mul(Matrix A, Matrix B) {
    int n = A.n;
    Matrix C;
    C.n = A.n;
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            C.a[i][j] = 0;
            for (int k = 1; k <= n; k++) {
                C.a[i][j] = (C.a[i][j] + (1ll * A.a[i][k] * B.a[k][j]) % MOD ) % MOD;
            }
        }
    }
    return C;
}

int main() {
//    freopen("D3.txt", "r", stdin);
    
    cin >> C >> W >> H;
    
    // init;
    A.n = W + 1;
    int tmp = 1;
    A.a[1][1] = 1;
    for (int i = 2; i <= A.n; i++) {
        tmp = (1ll * tmp * H) % MOD;
        A.a[1][i] = tmp;
    }
    
    for (int i = 2; i <= A.n; i++) {
        A.a[i][i - 1] = 1;
    }
    
    // for (int i = 1; i <= A.n; i++) {
    //     for (int j = 1; j <= A.n; j++) {
    //         cout << A.a[i][j] << " ";
    //     }
    //     cout << endl;
    // }
    
    Matrix Ak = poww(C + 1);
    
    cout << Ak.a[1][1] << endl;
    
}
