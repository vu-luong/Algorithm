#include <iostream>
#include <stack>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

const int MAXM = 1005;

char a[MAXM];
int d[MAXM], h[MAXM];
int n, m;
long long res;

int main() {
    scanf("%d %d", &n, &m); gets(a);
    FOR(i, 1, n) {
        gets(a + 1);
        FOR(j, 1, m)
            if (a[j] == '1') ++h[j]; else h[j] = 0;

        stack <int> S; S.push(0);
        d[0] = 0; h[0] = -1;
        FOR(j, 1, m) {
            while (h[S.top()] >= h[j]) S.pop();
            int k = S.top();
            S.push(j);
            d[j] = h[j] * (j - k) + d[k];
            res += d[j];
        }
    }
    printf("%lld", res);
}
