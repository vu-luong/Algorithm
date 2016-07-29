#include <cstdio>
#include <vector>
#include <cstring>
using namespace std;

typedef long long int64;

const int MAXN = 50005;
const int MAXA = 1000001;
const int64 BASE = (int64)1e9;

int a[MAXN];
bool prime[MAXA];
vector <int> p, c;
int n, h;

void Init() {
    memset(prime, true, sizeof(prime));
    for (int i = 2; i < MAXA; i++) {
        while (!prime[i]) ++i;
        p.push_back(i);
        c.push_back(0);
        for (int j = i * 2; j < MAXA; j += i) prime[j] = false;
    }
}

int ID(int x) {
    int lo = 0, hi = p.size() - 1;
    while (lo <= hi) {
        int mid = (lo + hi) >> 1;
        if (p[mid] == x) return mid;
        if (x < p[mid])
            hi = mid - 1;
        else
            lo = mid + 1;
    }
}

void Update(int x, const int value) {
    int i = 0;
    while (!prime[x]) {
        while (x % p[i] != 0) ++i;
        while (x % p[i] == 0) {
            x /= p[i];
            c[i] += value;
        }
    }

    if (x > 1) c[ID(x)] += value;
}

int64 Pow(int a, int b) {
    if (b == 1) return a;
    int64 tmp = Pow(a, b / 2);
    tmp = (tmp * tmp) % BASE;

    if (b % 2 == 0) return tmp;
    else return (tmp * a) % BASE;
}

int main() {
    scanf("%d %d", &n, &h);
    for (int i = n; i >= 1; i--) scanf("%d", &a[i]);

    int pos = n, minA = a[1];
    for (int i = 2; i <= n; i++)
        if (a[i] > minA) { pos = i; break; }
        else if (a[i] < minA) minA = a[i];
    printf("%d\n", pos);

    Init();
    ++n;
    for (int i = n + 2; i <= n * 2; i++) Update(i, 1);
    for (int i = 2; i <= n; i++) Update(i, -1);

    int64 res = 1;
    for (int i = 0; i < p.size(); i++)
        if (c[i]) res = (res * Pow(p[i], c[i])) % BASE;

    printf("%d", res);
}
