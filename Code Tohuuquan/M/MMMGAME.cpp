#include <iostream>
#include <cstdio>
#include <algorithm>
using namespace std;

const string res[] = { "Brother", "John" };

int nTests, n, maxA, s, x;

int main() {
    scanf("%d", &nTests);
    while (nTests--) {
        scanf("%d %d", &n, &x);
        s = maxA = x;
        for (int i = 1; i < n; i++)
            scanf("%d", &x), maxA = max(maxA, x), s ^= x;

        string t = (maxA == 1 ? res[n % 2 == 0] : res[s > 0]);
        puts(t.c_str());
    }
}
