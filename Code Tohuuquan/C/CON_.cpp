#include <iostream>
#define FR(i, a, b) for(int i = a; i < b; i++)
using namespace std;

const int MAXN = 100005;

int a[MAXN], b[MAXN];
int n;

int main() {
    scanf("%d", &n);
    FR(i, 0, n) scanf("%d", b + i);

    if (n % 3 == 0) {
        a[0] = a[1] = 1;
        FR(i, 2, n)
            a[i] = b[(i + n - 1) % n]
                 - a[(i + n - 2) % n] - a[(i + n - 1) % n];
    }
    else {
        a[0] = 0;
        int j = 0;
        FR(i, 1, n) {
            j = (j + 3) % n;
            a[j] = a[(j + n - 3) % n]
                 + b[(j + n - 1) % n] - b[(j + n - 2) % n];
        }
        int delta = (b[1] - (a[0] + a[1] + a[2])) / 3;
        FR(i, 0, n) a[i] += delta;
    }

    FR(i, 0, n) printf("%d ", a[i]);
}
