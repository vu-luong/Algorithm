#include <bits/stdc++.h>

#define PB push_back
#define MP make_pair
#define SZ(a) a.size()
#define DEBUG(x) cout << #x << " = " << x << endl;

#define PR(A,n)  { cout << #A << " = "; for (int i = 1, _n = (n); i <= _n; i++) \
                    cout << A[i] << ' '; cout << endl; }
#define PR0(A,n) { cout << #A << " = "; for (int i = 0, _n = (n); i < _n; i++) \
                    cout << A[i] << ' '; cout << endl; }

using namespace std;

double x[300], y[300];
int n;
double kc2(double x1, double y1, double x2, double y2) {
    return (x2 - x1)*(x2 - x1) + (y2 - y1)*(y2 - y1);
}

bool check(double tx, double ty, double r) {
    for (int i = 1; i <= n; i++) {
        if (kc2(tx, ty, x[i], y[i]) > r) {
            return false;
        }
    }

    return true;
}

double kc(double x1, double y1, double x2, double y2) {
    return sqrt(kc2(x1, y1, x2, y2));
}

int main() {
    freopen("B.txt", "r", stdin);
 
    cin >> n;
    for (int i = 1; i <= n; i++) {
        cin >> x[i] >> y[i];
    }

    double dis = 0;
    int im = 0;
    int jm = 0;
    for (int i = 1; i <= n - 1; i++) {
        for (int j = i + 1; j <= n; j++) {
            double tx = (x[i] + x[j]) / 2;
            double ty = (y[i] + y[j]) / 2;
            double r = kc2(tx, ty, x[i], y[i]);

            if (check (tx, ty, r)) {
                printf("%0.6f", sqrt(r));
                return 0;
            }

            double dis = kc(x[i], y[i], x[j], y[j]);
            if (dis > dis_max) {
                dis_max = dis;
                im = i;
                jm = j;
            }
        }
    }

    for (int i = 1; i <= n; i++) {
        if (i != im && i != jm) {
            double a = kc(x[i], y[i], x[im], y[im]);
            double b = kc(x[i], y[i], x[jm], y[jm]);
            double c = dis_max;

            double s = sqrt((a + b + c)*(b + c - a)*(c + a - b)*(a + b - c));

            double r = a*b*c/s;


        }
    }

}
