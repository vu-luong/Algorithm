#include <iostream>
#include <algorithm>
#include <cstring>
using namespace std;

const int MAXN = 200005;

struct TInfo {
    char q;
    int x;
};

TInfo a[MAXN];
bool outside[MAXN];
int f[MAXN], c[MAXN];
int n, m = 0;

bool cmp(int u, int v) { return a[u].x < a[v].x; }

void Enter() {
    scanf("%d\n", &n);
    for (int i = 0; i < n; i++) {
        scanf("%c %d\n", &a[i].q, &a[i].x);
        f[i] = i;
    }

    sort(f, f + n, cmp);
    int value = a[f[0]].x, num = 1;
    a[f[0]].x = 1;
    c[1] = value;
    for (int i = 1; i < n; i++)
        if (a[f[i]].q != 'K')
            if (a[f[i]].x == value)
                a[f[i]].x = num;
            else {
                value = a[f[i]].x;
                a[f[i]].x = ++num;
                c[num] = value;
            }
}

void Insert(int x) {
    if (outside[x]) {
        ++m;
        outside[x] = false;
        while (x <= n) ++f[x], x += x & -x;
    }
}

void Delete(int x) {
    if (!outside[x]) {
        --m;
        outside[x] = true;
        while (x <= n) --f[x], x += x & -x;
    }
}

int Sum(int x) {
    int res = 0;
    while (x) res += f[x], x -= x & -x;
    return res;
}

int FindK(int x) {
    int lo = 1, hi = n;
    while (lo < hi) {
        int mid = (lo + hi) / 2;
        if (x > Sum(mid))
            lo = mid + 1;
        else
            hi = mid;
    }
    return c[hi];
}

void Solve() {
    memset(f, 0, sizeof(f));
    memset(outside, true, sizeof(outside));
    for (int i = 0; i < n; i++)
        switch (a[i].q) {
            case 'I' :
                Insert(a[i].x);
                break;

            case 'D' :
                Delete(a[i].x);
                break;

            case 'K' :
                if (a[i].x > m)
                    printf("invalid\n");
                else
                    printf("%d\n", FindK(a[i].x));
                break;

            case 'C' :
                printf("%d\n", Sum(a[i].x - 1));
                break;
        }
}

int main() {
    Enter();
    Solve();
}
