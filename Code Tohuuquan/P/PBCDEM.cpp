#include <cstdio>
#include <vector>
#include <algorithm>
using namespace std;

const int MAXN = 4005;
const int SIZE = 91;
const int BASE = (int)1e9;

typedef vector <int> BigInt;

BigInt operator + (BigInt a, BigInt b) {
    BigInt c;
    int carry = 0;
    for (int i = 0; i < a.size() || i < b.size(); i++) {
        if (i < a.size()) carry += a[i];
        if (i < b.size()) carry += b[i];
        c.push_back(carry % BASE);
        carry /= BASE;
    }
    if (carry) c.push_back(carry);

    return c;
}

void Print(BigInt a) {
    int L = a.size();
    printf("%d", a[L - 1]);
    for (int i = L - 2; i >= 0; i--)
        printf("%09d", a[i]);
}

BigInt f[MAXN][SIZE];
int n;

int main() {
    scanf("%d", &n);

    for (int i = 1; i <= n; i++) f[i][1].push_back(1);
    for (int i = 2; i <= n; i++)
        for (int j = 2; j < SIZE; j++)
            if (i == j * (j + 1) / 2)
                f[i][j].push_back(1);
            else if (i > j * (j + 1) / 2)
                f[i][j] = f[i - j][j] + f[i - j][j - 1];

    BigInt res;
    for (int j = 2; j < SIZE; j++)
        res = res + f[n][j];

    Print(res);
}
