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

const int MAXN = 115;
const double e = 1e-10;

pair <double, double> a[MAXN];
vector< pair<double, double> > vs;
vector< pair<double, double> > s, v1, v2;



int n;
int mark = 0;
double sall;

int pos;

double cal(vector< pair<double, double> > ps) {
    double area = 0;

    for (int i = 1; i < ps.size(); i++) {
        area += (abs(ps[i].second) + abs(ps[i - 1].second))*(ps[i].first - ps[i - 1].first)*1.0f/2;
    }

    area += (abs(ps[0].second) + abs(ps[ps.size() - 1].second))*(ps[0].first - ps[ps.size() - 1].first)*1.0f/2;

    return abs(area);
}

void print(double x1, double y1, double x2, double y2, bool left) {
    double c = (x1*x2 + y1*y2)/(sqrt(x1*x1 + y1*y1)*sqrt(x2 * x2 + y2*y2));


    double l = sqrt(x1*x1 + y1*y1);


    double y = c*l;

    double x = sqrt(l*l - y*y);


    if (left) {
        double res1 = -abs(x);
        double res2 = -abs(y);
        if (abs(res1) < e) res1 = 0;
        if (abs(res2) < e) res2 = 0;
        printf("%0.6f %0.6f\n", res1, res2);

    } else {
        double res1 = abs(x);
        double res2 = -abs(y);
        if (abs(res1) < e) res1 = 0;
        if (abs(res2) < e) res2 = 0;
        printf("%0.6f %0.6f\n", res1, res2);
    }
}

void process(double x, double y) {

    printf("%0.6f %0.6f\n", a[1].first*1.0f, a[1].second*1.0f);
    for (int i = 2; i <= pos; i++) {
        print(a[i].first, a[i].second, x, y, true);
    }
    for (int i = pos + 1; i <= n; i++) {
        print(a[i].first, a[i].second, x, y, false);
    }
}

void xuly(int test) {
    cin >> n;
    cout << "Case " << test << ":" << endl;
    vs.clear();
    s.clear();
    v1.clear();
    v2.clear();

    for (int i = 1; i <= n; i++) {
        int u, v;
        cin >> u >> v;
        a[i] = {u, v};
        vs.PB({u, v});
    }

    sall = cal(vs);

    s.PB(a[1]);
    s.PB(a[2]);

    double ss;

    for (int i = 3; i <= n; i++) {
        s.PB(a[i]);
        ss = cal(s);
        if ( ss - (sall - ss) >= e) {
            pos = i - 1;
            break;
        }
    }

    double x1 = a[pos].first;
    double y1 = a[pos].second;
    double x2 = a[pos + 1].first;
    double y2 = a[pos + 1].second;

    for (int i = 1; i <= pos; i++) {
        v1.PB({a[i]});
    }

    for (int i = pos + 1; i <= n; i++) {
        v2.PB({a[i]});
    }
    v2.PB(a[1]);
    if (x1 != x2) {
        double first = x1;
        double last = x2;
        bool less = false;
        if (first <= last) less = true;
        while (true) {
            if (less) {
                if (first + e >= last) break;
            } else {
                if (last + e >= first) break;
            }
            double midx = (first + last) / 2;
            double midy = y1 + (midx - x1)*(y2 - y1)/(x2 - x1);
            v1.PB({midx, midy});
            v2.PB({midx, midy});

            double s1 = cal(v1);
            double s2 = cal(v2);

            v1.pop_back();
            v2.pop_back();

            if (abs(s1 - s2) < 1e-8) {
                process(midx, midy);
                return;
            } else {
                if (s1 - s2 < 0) {
                    first = midx;
                } else {
                    last = midx;
                }
            }
        }
    } else {
        double first = y1;
        double last = y2;
        bool less = false;
        if (first <= last) less = true;
        while (true) {
            if (less) {
                if (first + e >= last) break;
            } else {
                if (last + e >= first) break;
            }
            double midy = (first + last) / 2;
            double midx = x1 + (midy - y1)*(x2 - x1)/(y2 - y1);

            v1.PB({midx, midy});
            v2.PB({midx, midy});

            double s1 = cal(v1);
            double s2 = cal(v2);

            v1.pop_back();
            v2.pop_back();

            if (abs(s1 - s2) < 1e-8) {
                process(midx, midy);
                return;
            } else {
                if (s1 - s2 < 0) {
                    first = midy;
                } else {
                    last = midy;
                }
            }

        }

    }

}

int main() {
    //freopen("A.txt", "r", stdin);

    int Test;
    cin >> Test;

    for (int test = 1; test <= Test; test++) {
        xuly(test);
    }
}
