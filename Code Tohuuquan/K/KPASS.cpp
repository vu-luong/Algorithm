#include <iostream>
#include <cstdio>
#include <cstring>
using namespace std;

const int MAXN = 35, MAXK = MAXN;

int b[MAXN], s[MAXN], c[MAXN][MAXK];
int n, k, x;

int Cal(int i, int cnt) {
    int &res = c[i][cnt];
    if (res != -1) return res;

    if (cnt > k)
        res = 0;
    else if (i > n)
        res = 1;
    else
        res = Cal(i + 1, cnt + 1) + Cal(i + 1, 0);

    return res;
}

void Trace(int i, int cnt) {
    if (i > n) return;

    if (x <= Cal(i + 1, cnt + 1)) {
        b[i] = 0;
        Trace(i + 1, cnt + 1);
    } else {
        b[i] = 1;
        x -= Cal(i + 1, cnt + 1);
        Trace(i + 1, 0);
    }
}

int main() {
    cin >> n >> x >> k;

    memset(c, -1, sizeof(c));
    Trace(1, 0);

    int num = 0;
    for (int i = 1; i <= n; i++)
        num = num * 2 + b[i];
    for (int i = n; i > 0; i--)
        s[i] = num % 10, num /= 10;

    for (int i = 1; i <= n; i++)
        cout << s[i] << " ";
}
