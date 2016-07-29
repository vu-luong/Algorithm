#include <cstdio>
#include <stack>
#include <algorithm>
using namespace std;

const int MAXN = (int)1e6 + 5;

int h[MAXN], l[MAXN], r[MAXN];
int N, res = 0;

int main() {
    scanf("%d", &N);
    for (int i = 1; i <= N; i++)
        scanf("%d", h + i);

    stack <int> S;
    S.push(0);
    for (int i = 1; i <= N; i++) {
        while (h[S.top()] >= h[i]) S.pop();
        l[i] = S.top();
        S.push(i);
    }

    S.push(N + 1);
    for (int i = N; i >= 1; i--) {
        while (h[S.top()] >= h[i]) S.pop();
        r[i] = S.top();
        S.push(i);
    }

    for (int i = 1; i <= N; i++)
        if (r[i] - l[i] - 1 >= h[i])
            res = max(res, h[i]);

    printf("%d", res);
}
