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

double mean[100];

double a[100][100];
int n, m;
double b[100][100];

int main() {
    freopen("base.txt", "r", stdin);
    
    cin >> m >> n;

    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            cin >> a[i][j];
        }
    }

    for (int j = 1; j <= n; j++) {

        double sum = 0;

        for (int i = 1; i <= m; i++) {
            sum += a[i][j];
        }

        mean[j] = sum / m;

        double sd = 0;

        for (int i = 1; i <= m; i++) {
            sd += (a[i][j] - mean[j]) * (a[i][j] - mean[j]);
        }

        sd /= m;
        sd = sqrt(sd);
        DEBUG(mean[j]);
        
        for (int i = 1; i <= m; i++) {
            a[i][j] = (a[i][j] - mean[j]) / sd;
        }
    }

    double s = 0;
    for (int i = 1; i <= m; i++) {
        s += (a[i][1] * a[i][1]);
        for (int j = 1; j <= n; j++) {
            cout << a[i][j] << " ";
        }

        cout << endl;
    }
    DEBUG(s);

    memset(b, 0, sizeof(b));

    for (int i = 1; i <= m; i++) {
        
        for (int i1 = 1; i1 <= n; i1++) {
            for (int i2 = 1; i2 <= n; i2++) {
                double t = a[i][i1] * a[i][i2];
                b[i1][i2] += t;
            }
        }
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            b[i][j] /= m;
        }
    }

    cout << endl << "-----------------" << endl;
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            cout << b[i][j] << " ";
        }
        cout << endl;
    }

}
