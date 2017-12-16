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
const int MAXN = (int) 1e5 + 55;
stack< pair<long long, int> > st;
int n;
long long L[MAXN], H[MAXN];
int l[MAXN];
long long s[MAXN], sum[MAXN];

int main() {
    //freopen("B.txt", "r", stdin);
    int ntest;
    cin >> ntest;

    while (ntest --) {
        memset(L, 0, sizeof(L));
        memset(H, 0, sizeof(H));
        memset(l, 0, sizeof(l));
        memset(s, 0, sizeof(s));
        memset(sum, 0, sizeof(sum));

        scanf("%d", &n);
        for (int i = 1; i <= n; i++) {
            scanf("%lld", &L[i]);
        }
    
        sum [0] = 0;
        for (int i = 1; i <= n; i++) {
            scanf("%lld", &H[i]);
            sum[i] = sum[i - 1] + H[i];
        }
        
        l[1] = 0;
        st = stack< pair<long long, int> >();
        st.push(make_pair(H[1], 1));

        for (int i = 2; i <= n; i++)  {

            while (!st.empty() && H[i] >= st.top().first) {
                st.pop();
            }

            if (st.empty()) l[i] = 0;
            else l[i] = st.top().second;

            st.push(make_pair(H[i], i));
        }

        s[0] = 0;
        s[1] = 1ll*H[1]*L[1];
        L[0] = -1;
        for (int i = 2; i <= n; i++) {
            if (H[i] <= H[i - 1]) {
                s[i] = s[i - 1] + H[i]*(L[i] - L[i - 1] - 1);
            } else {
                int left = l[i];
                s[i] = s[left] + H[i]*(L[i] - L[left] - 1) - (sum[i - 1] - sum[left]);
            }
        }
        int q;
        cin >> q;
        while (q--) {
            long long k;
            cin >> k;
            
            if (k > s[n]) {
                cout << n << endl;
                continue;
            }
            if (k <= s[1]) {
                cout << 0 << endl;
                continue;
            } 

            int left = 0;
            int right = n + 1;
            while (left + 1 < right) {
                int mid = (left + right) / 2;
                if (s[mid] >= k) {
                    right = mid;
                } else {
                    left = mid;
                }
            }

            cout << right - 1 << endl;

        }
    }
}
