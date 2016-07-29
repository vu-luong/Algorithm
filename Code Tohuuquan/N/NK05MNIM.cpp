#include <iostream>
#include <cstdio>
#include <algorithm>
using namespace std;

const int res[] = { -1, 1 };

int nTests, n, maxA, s, x;

int main() {
    scanf("%d", &nTests);
    while (nTests--) {
        scanf("%d %d", &n, &x);
        s = maxA = x;
        for (int i = 1; i < n; i++)
            scanf("%d", &x), maxA = max(maxA, x), s ^= x;

        printf("%d\n", maxA == 1 ? res[n % 2 == 0] : res[s > 0]);
    }
}
