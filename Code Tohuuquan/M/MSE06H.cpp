#include <iostream>
#include <vector>
#include <algorithm>
#include <cstring>
using namespace std;

const int MAXM = 1005;

typedef long long int64;

int64 node[MAXM];
int nTests, n, m, k;

int64 Get(int x) {
    int64 res = 0;
    while (x <= m) {
        res += node[x];
        x += x & -x;
    }
    return res;
}

void Update(int x) {
    while (x > 0) {
        ++node[x];
        x -= x & -x;
    }
}

int main() {
    scanf("%d", &nTests);
    for (int t = 1; t <= nTests; t++) {
        scanf("%d %d %d", &n, &m, &k);
        vector < pair <int, int> > a;
        for (int i = 0; i < k; i++) {
            int x, y; scanf("%d %d", &x, &y);
            a.push_back(make_pair(x, y));
        }
        sort(a.begin(), a.end());

        memset(node, 0, sizeof(node));
        int64 res = 0;
        int last = 0;
        for (int i = 1; i < k; i++) {
            if (a[i].first != a[i - 1].first) {
                for (int j = last; j < i; j++) Update(a[j].second);
                last = i;
            }
            res += Get(a[i].second + 1);
        }

        printf("Test case %d: %lld\n", t, res);
    }
}
