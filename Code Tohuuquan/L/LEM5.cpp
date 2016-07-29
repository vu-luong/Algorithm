#include <iostream>
#include <algorithm>
using namespace std;

const int MAXN = 100005;
const int MAXD = 100;

typedef pair <int, int> TNum;
#define val first
#define id  second

TNum a[MAXN];
int f[MAXN];
int n, res = 1;

int Find(int lo, int hi, const TNum key) {
    while (lo <= hi) {
        int mid = (lo + hi) >> 1;
        if (a[mid] > key)
            hi = mid - 1;
        else
            lo = mid + 1;
    }
    return hi;
}

int main() {
    scanf("%d", &n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &a[i].val);
        a[i].id = i;
    }
    sort(a, a + n);

    for (int d = 1; d <= MAXD; d++)
        for (int i = 0; i < n; i++) {
            f[i] = 1;

            TNum key(a[i].val - d, a[i].id - 1);
            int j = Find(0, i - 1, key);

            for (int k = j; k >= 0, a[k].val == key.val; k--)
                f[i] = max(f[i], f[k] + 1);
            for (int k = j + 1; k < i; i++)
                if (a[k].val != key.val || a[k].id > key.id) break;
                else f[i] = max(f[i], f[j] + 1);

            res = max(res, f[i]);
        }

    printf("%d", res);
}
