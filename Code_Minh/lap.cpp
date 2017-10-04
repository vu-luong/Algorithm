#include<bits/stdc++.h>

using namespace std;

int n;
int a[100];

int main() {

    cout << "Nhap n" << endl;
    cin >> n;

    for (int i = 1; i <= n; i++) {
        cin >> a[i];
    }

    for (int i = 1; i <= n; i++) {
        cout << a[i] << endl;
    }

}
