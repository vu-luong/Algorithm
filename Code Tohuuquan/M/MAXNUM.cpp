#include <cstdio>
#include <algorithm>
using namespace std;

int N, P, res = 32 * 30000 + 1;

int Count(int x) {
    int res = 0;
    for (int i = x; i <= N; i *= x)
        res += N / i;

    return res;
}

int main() {
    scanf("%d %d", &N, &P);

    for (int i = 2; i * i <= P; i++)
        if (P % i == 0) {
            int cnt = 0;
            while (P % i == 0) ++cnt, P /= i;

            res = min(res, Count(i) / cnt);
        }
    if (P > 1) res = min(res, Count(P));

    printf("%d", res);
}
