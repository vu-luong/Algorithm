#include <iostream>
#include <cstdio>
using namespace std;

const int MAXB = 50;

typedef long long int64;

int64 C[MAXB + 1];
int64 A, B, res = 0;

int64 Cal(int64 A, int64 B, int64 v) {
    if (v > B) return 0;

    B -= B % v;
    A -= (A % v == 0 ? v : A % v);
    return (B - A) / v;
}

int main() {
    cin >> A >> B;

    C[0] = B - A + 1;
    for (int i = MAXB - 1; i >= 0; i--) {
        if (i > 0) C[i] = Cal(A, B, 1LL << i);
        for (int j = i + 1; j < MAXB; j++)
            C[i] -= C[j];
    }

    for (int i = 0; i < MAXB; i++)
        res += C[i] * (1LL << i);

    cout << res;
}
