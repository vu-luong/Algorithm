#include <cstdio>
#include <algorithm>
using namespace std;

const char res[2] = { 'S', 'T' };

int x, y;

bool isFirstWin(int x, int y) {
    if (y % x == 0) return y > x;
    if (!isFirstWin(y % x, x)) return true;
    return y > x + y % x;
}

int main() {
    while (scanf("%d %d", &x, &y)) {
        if (x == 0 && y == 0) break;
        printf("%c\n", res[isFirstWin(min(x, y), max(x, y))]);
    }
}
