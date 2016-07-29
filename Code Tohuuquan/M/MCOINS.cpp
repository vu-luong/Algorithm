#include <iostream>
using namespace std;

const int MAXN = (int)1e6 + 10;

bool f[MAXN];
int k, l, m, n;

int main() {
    scanf("%d %d %d", &k, &l, &m);
    while (m--) {
        scanf("%d", &n);
        f[0] = false;
        for (int i = 1; i <= n; i++) {
            f[i] = false;
            if (!f[i - 1]) f[i] = true;
            if (i >= k && !f[i - k]) f[i] = true;
            if (i >= l && !f[i - l]) f[i] = true;
        }

        if (f[n]) printf("A"); else printf("B");
    }
}
