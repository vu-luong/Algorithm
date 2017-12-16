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
const int MAXN = (int) 2e5 + 5;
int a[MAXN];
int n;

int main() {
    //freopen("283A.txt", "r", stdin);
    scanf("%d", &n);

    double sum = 0;
    int size = 1;
    a[size] = 0;

    for (int i = 1; i <= n; i++) {
        int t;
        scanf("%d", &t);

        if (t == 1) {
            int pos, val;
            scanf("%d %d", &pos, &val);
            a[pos] += val;
            sum += 1ll * pos * val;
        } else if (t == 2) {
            int val;
            scanf("%d", &val);
            size++;
            a[size] = val;
            a[size - 1] -= val;
            sum += val;
        } else {
            a[size - 1] += a[size];
            sum -= a[size];
            size--;
        }

        //PR(a, size);
        printf("%0.6f\n", sum / size);
    }

}
