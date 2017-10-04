#include <bits/stdc++.h>

using namespace std;
const int MAXN = 105;

string a[MAXN];
int n;

int main () {

    freopen("389B.txt", "r", stdin);
    cin >> n;
    for (int i = 1; i <= n; i++) {
        cin >> a[i];
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < n; j++) {
            if (j == 0 || j == n - 1) continue;
            if (i >= n - 1) continue;
            if (a[i][j] == '#') {

                if (a[i + 1][j] == '#' && a[i + 2][j] == '#' 
                        && a[i + 1][j - 1] == '#' && a[i + 1][j + 1] == '#') {
                    a[i][j] = '.';
                    a[i + 1][j - 1] = '.';
                    a[i + 1][j + 1] = '.';
                    a[i + 1][j] = '.';
                    a[i + 2][j] = '.';
                } else {
                    cout << "NO" << endl;
                    return 0;
                }
            }
        }
    }


    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < n; j++) {
            if (a[i][j] == '#') {
                cout << "NO" << endl;
                return 0;
            }
        }
    }

    cout << "YES" << endl;
}
