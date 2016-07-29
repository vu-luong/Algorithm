#include <iostream>
#include <cstring>
using namespace std;

const int MAXN = 1000000;

typedef long long int64;

int f[MAXN];
int n, p, a, b, c;
string st;

int main() {
    while (true) {
        do getline(cin, st);
        while (st != "[CASE]" && st != "[END]");

        if (st == "[END]") break;

        scanf("%d %d %d %d %d", &n, &p, &a, &b, &c);

        if (n & 1) {
            printf("0\n");
            continue;
        }

        memset(f, 0, sizeof(f));
        for (int64 i = 0; i < p; i++)
            ++f[((a * i * i) % n + (b * i) % n + c) % n];

        int num = 0;
        for (int loop = 0; loop < 2; loop++)
            for (int i = 0; i < n; i++)
                if (f[i] == 0 && num > 0)
                    f[i] = 1, --num;
                else if (f[i] > 1)
                    num += f[i] - 1, f[i] = 1;

        int64 res = 0;
        for (int i = 0; i < n; i++)
            if (f[i] && f[(i + (n / 2)) % n])
                res += p - 2;
        printf("%lld\n", res / 2);
    }
}
