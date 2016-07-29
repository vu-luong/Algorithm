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

int _x1, _x2, _y1, _y2;
const double eps = 1e-16;
bool cung;
double dis1, dis2;
int aa, bb;

int cal(int R) {

    int a = -(_y1 - _y2);
    int b = _x1 - _x2;

    int c = - (a * _x1 + b * _y1);

    double dis = abs(c);
    dis = dis / sqrt(a * a + b * b);
    int ans = 0;
    if (dis - R <= 0) {

        bool ok1;
        bool ok2;

        if (dis1 - R <= 0) ok1 = true;
        else ok1 = false;

        if (dis2 - R <= 0) ok2 = true;
        else ok2 = false;

        if (ok1 && ok2) {
            if (abs(dis1 - R) < eps && abs(dis2 - R) < eps) {
                return 2;
            }

            if (abs(dis1 - R) < eps || abs(dis2 - R) < eps) {
                return 1;
            }
            return 0;
        }
        else if (!ok1 && !ok2) {
            if (!cung) {
                if (abs(dis - R) < eps) return 1;
                else return 2;
            } else {
                return 0;
            }
        }
        else {
            if (!cung && (abs(dis1 - R) < eps || abs(dis2 - R) < eps)) {
                return 2;
            }
            return 1;
        }

    }

    return ans;
}

int main() {
    // freopen("A.txt", "r", stdin);

    cin >> _x1 >> _y1 >> _x2 >> _y2;

    int kc1 = _x1 * _x1 + _y1 * _y1;
    int kc2 = _x2 * _x2 + _y2 * _y2;
    int kc = max(kc1, kc2);
    int MAXN = trunc(sqrt(kc)) + 15;

    dis1 = sqrt(kc1);
    dis2 = sqrt(kc2);

    // DEBUG(dis1);
    // DEBUG(dis2);

    aa = _x1 - _x2;
    bb = _y1 - _y2;

    int test1 = aa*_x1 + bb*_y1;
    int test2 = aa*_x2 + bb*_y2;
    long long test = 1ll*test1 * test2;
    if (test >= 0) cung = true;
    else cung = false;

    // DEBUG(cung);

    int res = 0;

    for (int n = 1; n <= MAXN; n++) {
        int ans = cal(n);
        // cout << ans << endl;
        res += ans;

    }

    cout << res << endl;

}
