#include <cstdio>
#include <algorithm>
#include <cstring>
using namespace std;

const int MAXN = 1500;

typedef long long int64;

struct TRay {
    int64 x, y;
    int q;

    friend bool operator < (TRay u, TRay v) {
        return u.y * v.x < u.x * v.y;
    }

    void Rotate() {
        int64 t = x; x = y; y = -t;
        q = (q + 1) % 4;
    }

    friend bool AngleEqual(TRay u, TRay v) {
        return u.y * v.x == u.x * v.y;
    }
};

int x[MAXN], y[MAXN], cnt[4];
TRay ray[MAXN];
int n, res = 0;

void Enter() {
    scanf("%d", &n);
    for (int i = 0; i < n; i++)
        scanf("%d %d", &x[i], &y[i]);
}

void MakeRay(int root) {
    for (int i = 0; i < n; i++) {
        ray[i].x = x[i] - x[root];
        ray[i].y = y[i] - y[root];
        ray[i].q = 0;

        if (i == root) ray[i] = ray[0]; else
            while (ray[i].x <= 0 || ray[i].y < 0) ray[i].Rotate();
    }
}

void Update() {
    for (int i = 1; i < n; ) {
        memset(cnt, 0, sizeof(cnt));
        int j = i;
        while (j < n && AngleEqual(ray[i], ray[j])) {
            ++cnt[ray[j].q];
            ++j;
        }
        i = j;

        res += cnt[0] * cnt[3];
        for (int j = 0; j < 3; j++)
            res += cnt[j] * cnt[j + 1];
    }
}

void Solve() {
    for (int i = 0; i < n; i++) {
        MakeRay(i);
        sort(ray + 1, ray + n);
        Update();
    }

    printf("%d", res);
}

int main() {
    Enter();
    Solve();
}
