#include <bits/stdc++.h>

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
bool equal(int i, string name) {
    for (int j = i; j <= i + name.length() - 1; j++) {
        if (s[j] != name[j - i]) return false;
    }
    return true;
}

int cal(string name) {
    if (s.length() < name.length()) return 0;
    int ans = 0;
    for (int i = 0; i <= s.length() - name.length(); i++) {
        if (equal(i, name)) ans++;
    }

    return ans;
}
int main() {
//    freopen("877A.txt", "r", stdin);
    
    cin >> s;

    if (cal("Danil") + cal("Olya") + cal("Slava") + 
            cal("Ann") + cal("Nikita") == 1) cout << "YES" << endl;
    else cout << "NO" << endl;
}
