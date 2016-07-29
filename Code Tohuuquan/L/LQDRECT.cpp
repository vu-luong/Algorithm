#include <cstdio>
#include <vector>
#define FOR(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

const int MAXM = 1005, MAXN = 305;

bool a[MAXM][MAXN];
int c[MAXN][MAXN];
int M, N;
long long res;

int main() {
    scanf("%d %d", &M, &N);
    FOR(i, 1, M) FOR(j, 1, N)
        scanf("%d", &a[i][j]);

    FOR(i, 1, M) {
        vector <int> S;
        FOR(j, 1, N)
            if (a[i][j]) {
                S.push_back(j);
                for (int k = 0; k < S.size(); k++)
                    ++c[S[k]][j];
            }
    }

    FOR(L, 1, N) FOR(R, L + 1, N)
        res += (c[L][R] * (c[L][R] - 1)) >> 1;

    printf("%lld", res);
}
