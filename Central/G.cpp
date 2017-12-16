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

bool r[200];
int n, m;
int a[200][200];
bool rr[200];
int main() {
    //freopen("G.txt", "r", stdin);
 
    cin >> n >> m;

    memset(r, true, sizeof(r));
    memset(rr, true, sizeof(rr));
    for (int i = 1; i <= n; i++) {
        cin >> s;
        for (int j = 1; j <= m; j++) {
            a[i][j] = (s[j - 1] == '#');
            if (a[i][j] == 1) {
                r[i] = true;
            }
        }
    }

    set<int> s;
    int sh = 0;
    for (int i = 1; i <= n; i++) {
        if (r[i]) {
            set<int> st (s);
            for (int j = 1; j <= m; j++) {
                if (a[i][j] == 1) {
                    st.insert(j);
                }
            }

            int t1 = s.size() + 1;
            int t2 = st.size();

            if (t1 >= t2) {
                s = set<int> (st);
            } else {
                sh ++;
                rr[i] = true;
            }
        }
    }

    for (int i = 1; i <= n; i++) {
        if (rr[i]) {
            bool ok = false;
            for (int j = 1; j <= m; j++) {
                if (s.find(j) == s.end()) {
                    ok = true;
                    break;
                }
            }
            if (!ok) sh--;
        }
    }

    cout << s.size() + sh << endl;

}
