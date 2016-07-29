#include <iostream>
#include <algorithm>
#include <cmath>
#include <vector>
#include <cstring>
using namespace std;

const int MAXN = 50000;
const int MAXC = 1000001;

typedef pair <int, int> TNum;
#define col first
#define val second

TNum a[MAXN];
int c[MAXC];
bool prime[MAXC];
vector <int> p, fac, pw;
int n, res = 0;

void Enter() {
    scanf("%d", &n);
    for (int i = 0; i < n; i++) scanf("%d", &a[i].val);
    sort(a, a + n);
}

void Init() {
    memset(prime, true, sizeof(prime));
    for (int i = 2; i < MAXC; i++) {
        while (!prime[i]) ++i;
        p.push_back(i);
        for (int j = i * 2; j < MAXC; j += i) prime[j] = false;
    }
}

void Cal(int x) {
    fac.clear(); pw.clear();

    int i = 0, j = 0;
    while (!prime[x]) {
        while (x % p[i] != 0) ++i;

        fac.push_back(p[i]);
        pw.push_back(0);

        while (x > 1 && x % p[i] == 0) {
            x /= p[i];
            ++pw[j];
        }
        ++j;
    }

    if (x > 1) fac.push_back(x), pw.push_back(1);
}

void Get(int i, int x, const int pos) {
    if (i == fac.size()) {
        a[pos].col = max(a[pos].col, c[x] + 1);
        a[pos].col = max(a[pos].col, c[a[pos].val / x] + 1);
        return;
    }

    int tmp = 1, lim = (int)sqrt(a[pos].val);
    for (int j = 0; j <= pw[i]; j++) {
        if (x * tmp > lim) break;
        Get(i + 1, x * tmp, pos);
        tmp *= fac[i];
    }
}

void Solve() {
    Init();
    for (int i = 0; i < n; i++) {
        if (i > 0 && a[i].val == a[i - 1].val)
            a[i].col = a[i - 1].col + 1;
        else {
            Cal(a[i].val);
            Get(0, 1, i);
        }

        c[a[i].val] = max(c[a[i].val], a[i].col);
        res = max(res, a[i].col);
    }
}

void Print() {
    sort(a, a + n);

    printf("%d\n", res);
    for (int i = 0; i < n; ) {
        int j = i;
        while (j < n && a[i].col == a[j].col) ++j;

        printf("%d", j - i);
        for (int k = i; k < j; k++) printf(" %d", a[k].val);
        printf("\n");

        i = j;
    }
}

int main() {
    Enter();
    Solve();
    Print();
}
