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

double eps = 1e-7;
double n, p, s, v;
int main() {
    //freopen("E.txt", "r", stdin);
 
    cin >> n >> p >> s >> v;

    double first = 0;
    double last = 1000000;

    double t = n / (p * 1000000000);
    double a = log(n) / log(2);
    double b = s / v;

    while (first + eps < last) {
        double mid = (first + last) / 2;

        double tmp = t*sqrt(2)*log(a)*pow(a, mid*sqrt(2))
            - b / (mid*mid);

        if (tmp <= 0) {
            first = mid;
        } else {
            last = mid;
        }
    }

    double res = t*pow(a, first*sqrt(2)) + b*(1 + 1.0f/first);

    printf("%0.6f %0.6f\n", res, first);

}
