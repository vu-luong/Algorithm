#include <bits/stdc++.h>

using namespace std;

bool isPrimes(int i) {
    if (i <= 3) return true;
    for (int j = 2; j <= trunc(sqrt(i)); j++) {
        if (i % j ==0) return false;
    }

    return true;
}

int main() {
    int n;
    cin >> n;

    for (int i = n; i >= 2; i--) {
        if (isPrimes(i)) {
            cout << i << endl;
            return 0;
        }
    }


}
