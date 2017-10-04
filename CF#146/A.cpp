#include <map>
#include <set>
#include <cmath>
#include <cstdio>
#include <vector>
#include <string>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <algorithm>

#define PB push_back
#define MP make_pair
#define SZ(a) a.size()
#define DEBUG(x) cout << #x << " = " << x << endl;

#define PR(A,n)  { cout << #A << " = "; for (int i = 1, _n = (n); i <= _n; i++) \
                    cout << A[i] << ' '; cout << endl; }
#define PR0(A,n) { cout << #A << " = "; for (int i = 0, _n = (n); i < _n; i++) \
                    cout << A[i] << ' '; cout << endl; }

using namespace std;

string s;
bool mark[10000];

int main() {
//    freopen("A.txt", "r", stdin);
    
    cin >> s;

    int cnt = 0;
    for (int i = 0; i < s.length(); i++) {
        int num = s[i];

        if (!mark[num]) {
            mark[num] = true;
            cnt++;
        }
    }

    if (cnt % 2 == 1) cout << "IGNORE HIM!";
    else cout << "CHAT WITH HER!";

}
