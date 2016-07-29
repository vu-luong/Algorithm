#include <iostream>
#include <stack>
#include <vector>
#include <cstring>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

const int MAXN = 405, MAXM = MAXN;
typedef long long int64;

char a[MAXN][MAXM];
int d[MAXM], h[MAXM];
bool avail[5];
int n, m;
int64 res = 0;

inline bool Check(char c, char c1, char c2, char c3) {
    return (c == c1 || c == c2 || c == c3);
}

int64 Cal(char c1, char c2, char c3) {
    int64 cnt = 0;
    memset(h, 0, sizeof(h));
    FOR(i, 1, n) {
        FOR(j, 1, m)
            if (Check(a[i][j], c1, c2, c3)) ++h[j];
            else h[j] = 0;

        stack <int> S; S.push(0);
        d[0] = 0; h[0] = -1;
        FOR(j, 1, m) {
            while (h[S.top()] >= h[j]) S.pop();
            int k = S.top();
            S.push(j);
            d[j] = h[j] * (j - k) + d[k];
            cnt += d[j];
        }
    }
    return cnt;
}

int main() {
    scanf("%d %d", &n, &m); gets(a[0]);
    FOR(i, 1, n) gets(a[i] + 1);
    for (char x = 'A'; x <= 'C'; x++)
        for (char y = x + 1; y <= 'D'; y++)
            for (char z = y + 1; z <= 'E'; z++)
                res += Cal(x, y, z) + Cal(x, x, x) + Cal(y, y, y) + Cal(z, z, z)
                                    - Cal(x, x, y) - Cal(x, x, z) - Cal(y, y, z);
    printf("%lld", res);
}
