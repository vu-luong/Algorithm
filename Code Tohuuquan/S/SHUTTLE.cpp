#include <cstdio>
#include <map>
#include <algorithm>
using namespace std;

const int MAXK = 50000;

struct TInfo {
    int S, E, M;

    bool operator < (const TInfo &v) const {
        return S < v.S;
    }
};

TInfo a[MAXK];
int k, n, c;

void Enter() {
    scanf("%d %d %d", &k, &n, &c);
    for (int i = 0; i < k; i++)
        scanf("%d %d %d", &a[i].S, &a[i].E, &a[i].M);

    sort(a, a + k);
}

void Solve() {
    map <int, int> off;
    map <int, int> :: iterator p;
    int total = 0, res = 0;

    for (int i = 0; i < k; i++) {
        for (p = off.begin(); p != off.end() && p->first <= a[i].S; ++p) {
            total -= p->second;
            res += p->second;
            off.erase(p);
        }

        off[a[i].E] += a[i].M;
        total += a[i].M;
        for (p = --off.end(); total > c; --p)
            if (total - p->second >= c) {
                total -= p->second;
                off.erase(p);
            }
            else {
                p->second -= total - c;
                total = c;
            }
    }

    res += total;
    printf("%d", res);
}

int main() {
    Enter();
    Solve();
}
