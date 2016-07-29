#include <iostream>
#define FR(i, a, b) for(int i = a; i < b; i++)
using namespace std;

int ex[11];
int n, res = 1;

int Pow(int a, int b) {
    if (b == 0) return 1;
    int t = Pow(a, b / 2);
    if (b % 2 == 0)
        return (t * t) % 10;
    else
        return ((a % 10) * t * t) % 10;
}

int main() {
    cin >> n;
    while (n > 0) {
        int numdis = n / 10;
        FR(i, 1, 10) ex[i] = numdis + 1;
        int mod = n % 10;
        FR(i, mod + 1, 10) --ex[i];

        FR(i, 1, 10)
            if (i != 5) res = (res * Pow(i, ex[i])) % 10;

        int numdiv5 = n / 5;
        int t = numdiv5 % 4;
        FR(i, 0, t)
            switch (res) {
                case 2 : res = 6; break;
                case 4 : res = 2; break;
                case 6 : res = 8; break;
                case 8 : res = 4; break;
            }
        n /= 5;
    }
    cout << res;
}
