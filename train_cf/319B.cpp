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
const int MAXN = (int) 1e5 + 10;

int n;
stack<int> st;
int ti[MAXN];
int a[MAXN];

int main() {
    //freopen("319B.txt", "r", stdin);
    
    cin >> n;
    for (int i = 1; i <= n; i++) {
        cin >> a[i];
    }

    st.push(1);
    ti[1] = -1;
    int res = -1;
    for (int i = 2; i <= n; i++ ){
        int cnt = 0;
        while (!st.empty() && a[st.top()] < a[i]){ 
            cnt = max(cnt, ti[st.top()] + 1); 
            st.pop();
        };
        if (st.empty()) ti[i] = -1;
        else ti[i] = cnt;
        st.push(i);
        //DEBUG(ti[i]);

        res = max(res, ti[i]);
    }
    cout << res + 1 << endl;
}
