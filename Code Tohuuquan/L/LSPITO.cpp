#include <cstdio>
#include <vector>
#include <algorithm>
using namespace std;

typedef long long int64;

const int64 MAXN = (int64)1e12;

vector <int64> f;
int64 n;

void Init() {
    for (int64 i = 2, delta = 3, flag = 0, len = 4; i <= MAXN; ) {
        f.push_back(i);
        if (delta == len) len *= 2, flag = 1;

        i += delta;
        delta += flag;
        flag ^= 1;
    }
}

inline bool Check(int64 n) {
    return binary_search(f.begin(), f.end(), n);
}

int main() {
    Init();

    while (scanf("%lld", &n) != EOF)
        puts(Check(n) ? "Thu Uyen" : "Conan");
}
