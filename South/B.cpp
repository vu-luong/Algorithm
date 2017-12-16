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

bool trong(double x1, double y1, double x2, double y2, double x3, double y3) {
    double tx = (x2 + x3) / 2;
    double ty = (y2 + y3) / 2;
    double r = kc(x2, y2, tx, ty);

    return (kc(x1, y1, tx, ty) <= r);
}

int main() {
    //freopen("B.txt", "r", stdin);
 
    cin >> n;
    for (int i = 1; i <= n; i++) {
        cin >> x[i] >> y[i];
    }

    for (int i = 1; i <= n - 1; i++) {
        for (int j = i + 1; j <= n; j++) {
            double tx = (x[i] + x[j]) / 2;
            double ty = (y[i] + y[j]) / 2;
            double r = kc2(tx, ty, x[i], y[i]);

            if (check (tx, ty, r)) {
                printf("%0.6f", sqrt(r));
                return 0;
            }
        }
    }

    double res = 0;

    for (int i = 1; i <= n - 2; i++) {
        for (int j = i + 1; j <= n - 1; j++) {
            for (int k = j + 1; k <= n; k++) {
                double a = kc(x[i], y[i], x[j], y[j]);
                double b = kc(x[i], y[i], x[k], y[k]);
                double c = kc(x[j], y[j], x[k], y[k]);
                double s = sqrt((a + b + c)*(b + c - a)*(c + a - b)*(a + b - c));
                double r = a*b*c/(s);
                if (trong(x[i], y[i], x[j], y[j], x[k], y[k])) continue;
                if (trong(x[j], y[j], x[i], y[i], x[k], y[k])) continue;
                if (trong(x[k], y[k], x[i], y[i], x[j], y[j])) continue;
                if (a + b > c && b + c > a && c + a > b) {
                    if (r > res) res = r;
                }

            }
        }
    }

    printf("%0.6f", res);

}
