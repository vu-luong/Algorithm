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

const int MAXN = (int) 3e5 + 5;

int n, k;
priority_queue< pair<long long, int> > pq;

long long c[MAXN];
int res[MAXN];

int main() {
//    ios_base::sync_with_stdio(false);
//    freopen("C.txt", "r", stdin);
    
    scanf("%d %d", &n, &k);

    for (int i = 1; i <= n; i++) {
        cin >> c[i];
    }

    for (int i = 1; i <= min(n, k + 1); i++) {
        pq.push(make_pair(c[i], i));
    }

    int last = min(n, k + 1);
    long long ans = 0;

    for (int i = 1; i <= n; i++) {
        long long v = pq.top().first; 
        int id = pq.top().second;
        pq.pop();

        res[id] = i + k;
        ans += (i + k - id) * v;
        last++;
        if (last <= n) {
            pq.push(make_pair(c[last], last));
        }
    }

    cout << ans << endl;
    for (int i = 1; i <= n; i++) {
        cout << res[i];
        if (i < n) cout << " ";
    }


}
