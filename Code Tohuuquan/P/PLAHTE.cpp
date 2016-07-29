#include <cstdio>
#include <vector>
#include <algorithm>
using namespace std;

const int MAXT = 1000005;

typedef long long int64;

int64 f[MAXT];
int cnt2[MAXT], cnt4[MAXT];
int N, M, x1, y1, x2, y2;
int64 res, add;

int64 StainedAtTime(int t) {
    int64 dx = min(x2, t) - max(x1, -t) + 1;
    int64 dy = min(y2, t) - max(y1, -t) + 1;

    return (dx <= 0 || dy <= 0) ? 0 : dx * dy;
}

void Cal(int t1, int t2) {
    int64 s0, s1, s2;
    s0 = StainedAtTime(t1 - 1);
    s1 = StainedAtTime(t1);
    s2 = StainedAtTime(t1 + 1);

    f[t1] += s1 - s0;
    f[t2] -= s1 - s0;

    if (t2 > t1 + 1) {
        int64 k = s0 + s2 - s1 * 2;
        f[t2] -= k * (t2 - t1);
        if (k == 2) ++cnt2[t1], --cnt2[t2];
        if (k == 4) ++cnt4[t1], --cnt4[t2];
    }
}

int main() {
    scanf("%d", &N);
    for (int i = 0; i < N; i++) {
        scanf("%d %d %d %d", &x1, &y1, &x2, &y2);

        vector <int> T;
        for (int d = -1; d <= 1; d++) {
            T.push_back(abs(x1 + d));
            T.push_back(abs(y1 + d));
            T.push_back(abs(x2 + d));
            T.push_back(abs(y2 + d));
        }

        sort(T.begin(), T.end());

        for (int i = 1; i < T.size(); i++)
            Cal(T[i - 1], T[i]);
    }

    scanf("%d", &M);
    vector <int> T(M);
    for (int i = 0; i < M; i++)
        scanf("%d", &T[i]);

    int it = 0;
    int64 k2 = 0, k4 = 0;
    for (int i = 0; i < T.size(); i++) {
        while (it <= T[i]) {
            res += add += f[it];
            add += 2 * (k2 += cnt2[it]) + 4 * (k4 += cnt4[it]);
            ++it;
        }
        printf("%lld\n", res);
    }
}
