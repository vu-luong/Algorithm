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
#include <queue>

#define PB push_back
#define MP make_pair
#define SZ(a) a.size()
#define DEBUG(x) cout << #x << " = " << x << endl;

#define PR(A,n)  { cout << #A << " = "; for (int i = 1, _n = (n); i <= _n; i++) \
    cout << A[i] << ' '; cout << endl; }
#define PR0(A,n) { cout << #A << " = "; for (int i = 0, _n = (n); i < _n; i++) \
    cout << A[i] << ' '; cout << endl; }

using namespace std;

const int MAXM = 50;

bool mark[8000000];
int f[8000000];
int a[10], b[10];

queue< vector<int> > q;
int n;

int cal(vector<int> v) {
    int res = 0;
    for (int i = 0; i < v.size(); i++) {
        res = res * 50 + v[i];
    }
    return res;
}

vector<int> pour(vector<int> u, int i, int j) {

    vector<int> v = u;
    if (u[i] <= a[j] - u[j]) {
        v[i] = 0;
        v[j] = v[j] + u[i];
        return v;
    } else {
        v[j] = a[j];
        v[i] = u[i] - (a[j] - u[j]);
        return v;
    }

}

void process() {
    scanf("%d", &n);

    vector<int> st;
    for (int i = 0; i < n; i++) {
        scanf("%d", &a[i]);
        st.PB(a[i]);
    }

    vector<int> fi;
    int num_fi;
    for (int i = 0; i < n; i++) {
        scanf("%d", &b[i]);
        fi.PB(b[i]);
    }

    num_fi = cal(fi);

    memset(mark, false, sizeof(mark));
    q = queue< vector<int> > ();

    q.push(st);
    mark[cal(st)] = true;
    f[cal(st)] = 0;

    if (cal(st) == num_fi) {
        cout << 0 << endl;
        return;
    }
    

    while (!q.empty()) {
        vector<int> u = q.front(); q.pop();            
        int num_u = cal(u);
 
//        DEBUG(num_u);

        vector<int> v = u;
        for (int i = 0; i <= n - 1; i++) {
            v[i] = 0;
            int num_v = cal(v);
            if (mark[num_v] == false) {
                mark[num_v] = true;
                f[num_v] = f[num_u] + 1;
                q.push(v);

                if (num_v == num_fi) {
                    cout << f[num_v] << endl;
                    return;
                }
            }
            v = u;
        }


        for (int i = 0; i <= n - 1; i++) {
            for (int j = 0; j <= n - 1; j++) {
                if (i != j) {
                    v = pour(u, i, j);
                    int num_v = cal(v);

                    if (mark[num_v] == false) {
//                        DEBUG(num_v);
                        mark[num_v] = true;
                        f[num_v] = f[num_u] + 1;
                        q.push(v);

                        if (num_v == num_fi) {
                            cout << f[num_v] << endl;
                            return;
                        }
                    }

                }

            }
        }

    }

    cout << "NO" << endl;

}

int main() {
//    freopen("CTAIN.txt", "r", stdin);

    int test;
    scanf("%d", &test);

    while (test--) {
        process();        
    }

}
