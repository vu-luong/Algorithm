#include <cstdio>
#include <vector>
#include <algorithm>
using namespace std;

const int MAX = 1234567890;

int N, K;

int Cal(int N, int K) {
    if (K == 0) return min(N - 1, MAX + 1);

    vector <int> F(1, 0);
    for (int i = 1; i < N; i++) {
        F.push_back(i);
        for (int j = max(0, i - K); j < i; j++)
            F[i] += F[j];
        if (F[i] > MAX) return F[i];
    }
    return F[N - 1];
}

int main() {
	while (scanf("%d %d", &N, &K))
        if (N == 0) break;
        else printf("%d\n", Cal(N, K));
}
