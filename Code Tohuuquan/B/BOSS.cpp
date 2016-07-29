#include <cstdio>
#include <map>
#include <algorithm>
using namespace std;

const int MAXN = 30000;

struct TInfo {
    int id, h, s, boss, c;

    bool operator < (TInfo u) const {
        return s < u.s;
    }
};

TInfo a[MAXN];
int nTests, N, Q;

int main() {
    scanf("%d", &nTests);
    while (nTests--) {
        scanf("%d %d", &N, &Q);
        for (int i = 0; i < N; i++) {
            scanf("%d %d %d", &a[i].id, &a[i].s, &a[i].h);
            a[i].boss = -1;
            a[i].c = 0;
        }

        sort(a, a + N);

        map <int, int> B;
        for (int i = 0; i < N; i++)
            B[a[i].id] = i;
        for (int i = N - 2; i >= 0; i--) {
            int b = i + 1;
            while (a[i].h > a[b].h) b = a[b].boss;
            a[i].boss = b;
        }
        for (int i = 0; i < N - 1; i++)
            a[a[i].boss].c += (1 + a[i].c);

        for (int i = 0; i < Q; i++) {
            int id; scanf("%d", &id);
            id = B[id];
            printf("%d ", a[id].boss < 0 ? 0 : a[a[id].boss].id);
            printf("%d\n", a[id].c);
        }
    }
}
