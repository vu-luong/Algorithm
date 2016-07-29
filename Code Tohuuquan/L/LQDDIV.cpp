#include <cstdio>
#include <vector>
#include <algorithm>
using namespace std;

typedef long long int64;

const int MAXN = 33;

int a[MAXN], bit[18];
int64 t[1 << 16];
vector <int64> b;
vector <int> c;
int n, n1, n2, num;
int64 res, sum;

void Enter() {
    scanf("%d", &n);
    for (int i = 1; i <= n; i++)
        scanf("%d", &a[i]);
}

void Init() {
    for (int i = 1; i <= n; i++) sum += a[i];
    res = sum;

    n1 = (n + 1) / 2;
    n2 = n - n1;

    bit[1] = 1;
    for (int i = 2; i <= n1 + 1; i++)
        bit[i] = bit[i - 1] << 1;

    for (int i = 0; i < bit[n1 + 1]; i++) {
        int64 value = 0;
        for (int j = 1; j <= n1; j++)
            if (i & bit[j]) value += a[j];

        t[i] = value;
    }
    sort(t, t + bit[n1 + 1]);

    for (int i = 0; i < bit[n1 + 1]; ) {
        int j = i + 1, cnt = 1;

        while (j < bit[n1 + 1] && t[i] == t[j])
            ++j, ++cnt;

        b.push_back(t[i]);
        c.push_back(cnt);

        i = j;
    }
}

void Solve() {
    for (int i = 0; i < bit[n2 + 1]; i++) {
        int64 value = 0;
        for (int j = 1; j <= n2; j++)
            if (i & bit[j]) value += a[n1 + j];

        int lo = 0, hi = b.size() - 1;
        int64 key = sum / 2 - value;
        while (lo <= hi) {
            int mid = (lo + hi) / 2;
            if (b[mid] > key)
                hi = mid - 1;
            else
                lo = mid + 1;
        }

        if (hi >= 0) {
            int64 tmp = sum - (b[hi] + value) * 2;
            if (res > tmp) res = tmp, num = 0;
            if (res == tmp) num += c[hi];
        }
        if (lo < b.size()) {
            int64 tmp = (b[lo] + value) * 2 - sum;
            if (res > tmp) res = tmp, num = 0;
            if (res == tmp) num += c[lo];
        }
    }
}

void Print() {
    printf("%lld %d", res, num / 2);
}

int main() {
    Enter();
    Init();
    Solve();
    Print();
}
