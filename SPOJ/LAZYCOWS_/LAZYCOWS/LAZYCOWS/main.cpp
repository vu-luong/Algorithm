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

const int MAXN = 2005;
const int oo = (int) 1e9 + 7;

struct data {
    int u, v;
};

int n, k ,b;

data s[MAXN];

bool mark[MAXN][10];
int f[MAXN][MAXN][11];
int p[MAXN];


bool cmp(data a, data b) {
    return (a.v < b.v || (a.v == b.v && a.u < b.u));
}

void process() {
    
    scanf("%d %d %d", &n, &k, &b);
    memset(mark, false, sizeof(mark));
    memset(p, 0, sizeof(p));
    
    for (int i = 1; i <= n; i++) {
        int u, v;
        scanf("%d %d", &u, &v);
        s[i] = {u, v};
    }
    
    sort(s + 1, s + n + 1, cmp);
    
    //        for (int i = 1; i <= n; i++) {
    //            cout << s[i].u << " " << s[i].v << endl;
    //        }
    
    mark[1][s[1].u] = true;
    p[1] = s[1].v;
    int cnt = 1;
    for (int i = 2; i <= n; i++) {
        if (s[i].v != s[i - 1].v) {
            cnt++;
            mark[cnt][s[i].u] = true;
            p[cnt] = s[i].v;
        } else {
            mark[cnt][s[i].u] = true;
        }
    }
    
    for (int i = 0; i <= cnt; i++) {
        for (int j = 0; j <= k; j++) {
            for (int q = 0; q <= 10; q++) {
                if (i == 0) f[i][j][q] = 0;
                else f[i][j][q] = oo;
            }
            
        }
    }
    
    
    for (int i = 1; i <= cnt; i++) {
        for (int j = 1; j <= k; j++) {
            
            if (mark[i][1] && mark[i][2]) {
                int res = oo;
                if (j >= 2) {
                    res = min(res, f[i - 1][j][1] + 2*(p[i] - p[i - 1]));
                    res = min(res, f[i - 1][j][3] + 2*(p[i] - p[i - 1]));
                    res = min(res, f[i - 1][j][4] + 2*(p[i] - p[i - 1]));
                    res = min(res, f[i - 1][j][5] + 2*(p[i] - p[i - 1]));
                }
                
                f[i][j][1] = res;

                res = oo;
                res = min(res, f[i - 1][j][2] + 2*(p[i] - p[i - 1]));
                res = min(res, f[i - 1][j][6] + 2*(p[i] - p[i - 1]));
                f[i][j][2] = res;
                
//                if (i == 4 && j == 2) {
//                    cout << "den day roi" << endl;
//                }
                
                res = oo;
                if (j >= 2) {
                    res = min(res, f[i - 1][j - 1][1] + p[i] - p[i - 1] + 1);
                    res = min(res, f[i - 1][j - 1][3] + p[i] - p[i - 1] + 1);
                    res = min(res, f[i - 1][j - 1][4] + p[i] - p[i - 1] + 1);
                    res = min(res, f[i - 1][j - 1][5] + p[i] - p[i - 1] + 1);
                    res = min(res, f[i - 1][j - 1][7] + p[i] - p[i - 1] + 1);
                    res = min(res, f[i - 1][j - 1][8] + p[i] - p[i - 1] + 1);
                }
                
                f[i][j][3] = res;
                
                res = oo;
                if (j >= 2) {
                    res = min(res, f[i - 1][j - 1][1] + p[i] - p[i - 1] + 1);
                    res = min(res, f[i - 1][j - 1][3] + p[i] - p[i - 1] + 1);
                    res = min(res, f[i - 1][j - 1][4] + p[i] - p[i - 1] + 1);
                    res = min(res, f[i - 1][j - 1][5] + p[i] - p[i - 1] + 1);
                    res = min(res, f[i - 1][j - 1][9] + p[i] - p[i - 1] + 1);
                    res = min(res, f[i - 1][j - 1][10] + p[i] - p[i - 1] + 1);
                }
                
                f[i][j][4] = res;
                
                res = oo;
                if (j >= 2) {
                    for (int r = 1; r <= 10; r++) {
                        res = min(res, f[i - 1][j - 2][r] + 2);
                    }
                }
                f[i][j][5] = res;
                
                res = oo;
                for (int r = 1; r <= 10; r++) {
                    res = min(res, f[i - 1][j - 1][r] + 2);
                }
                f[i][j][6] = res;
                
                f[i][j][7] = oo;
                f[i][j][8] = oo;
                f[i][j][9] = oo;
                f[i][j][10] = oo;
                
            } else {
                if (mark[i][1]) {
                    int res = oo;
                    if (j >= 2) {
                        res = min(res, f[i - 1][j][1] + 2*(p[i] - p[i - 1]));
                        res = min(res, f[i - 1][j][3] + 2*(p[i] - p[i - 1]));
                        res = min(res, f[i - 1][j][4] + 2*(p[i] - p[i - 1]));
                        res = min(res, f[i - 1][j][5] + 2*(p[i] - p[i - 1]));
                    }
                    
                    f[i][j][1] = res;
                    
                    res = oo;
                    res = min(res, f[i - 1][j][2] + 2*(p[i] - p[i - 1]));
                    res = min(res, f[i - 1][j][6] + 2*(p[i] - p[i - 1]));
                    f[i][j][2] = res;
                    
                    res = oo;
                    f[i][j][3] = res;
                    
                    res = oo;
                    if (j >= 2) {
                        res = min(res, f[i - 1][j - 1][1] + p[i] - p[i - 1] + 1);
                        res = min(res, f[i - 1][j - 1][3] + p[i] - p[i - 1] + 1);
                        res = min(res, f[i - 1][j - 1][4] + p[i] - p[i - 1] + 1);
                        res = min(res, f[i - 1][j - 1][5] + p[i] - p[i - 1] + 1);
                        res = min(res, f[i - 1][j - 1][9] + p[i] - p[i - 1] + 1);
                        res = min(res, f[i - 1][j - 1][10] + p[i] - p[i - 1] + 1);
                    }
                    
                    f[i][j][4] = res;
                    
                    res = oo;
                    f[i][j][5] = res;
                    
                    res = oo;
                    for (int r = 1; r <= 10; r++) {
                        res = min(res, f[i - 1][j - 1][r] + 2);
                    }
                    f[i][j][6] = res;
                    
//                    if (i == 5 && j == 2) {
//                        cout << "den day roi" << endl;
//                    }
                    
                    res = oo;
                    res = min(res, f[i - 1][j][1] + p[i] - p[i - 1]);
                    res = min(res, f[i - 1][j][3] + p[i] - p[i - 1]);
                    res = min(res, f[i - 1][j][4] + p[i] - p[i - 1]);
                    res = min(res, f[i - 1][j][5] + p[i] - p[i - 1]);
                    res = min(res, f[i - 1][j][7] + p[i] - p[i - 1]);
                    res = min(res, f[i - 1][j][8] + p[i] - p[i - 1]);
                    
                    f[i][j][7] = res;
                    
                    res = oo;
                    for (int r = 1; r <= 10; r++) {
                        res = min(res, f[i - 1][j - 1][r] + 1);
                    }
                    f[i][j][8] = res;
                    
                    f[i][j][9] = oo;
                    f[i][j][10] = oo;
                    
                } else {
                    int res = oo;
                    if (j >= 2) {
                        res = min(res, f[i - 1][j][1] + 2*(p[i] - p[i - 1]));
                        res = min(res, f[i - 1][j][3] + 2*(p[i] - p[i - 1]));
                        res = min(res, f[i - 1][j][4] + 2*(p[i] - p[i - 1]));
                        res = min(res, f[i - 1][j][5] + 2*(p[i] - p[i - 1]));
                    }
                    
                    f[i][j][1] = res;
                    
                    res = oo;
                    res = min(res, f[i - 1][j][2] + 2*(p[i] - p[i - 1]));
                    res = min(res, f[i - 1][j][6] + 2*(p[i] - p[i - 1]));
                    f[i][j][2] = res;
                    
                    res = oo;
                    if (j >= 2) {
                        res = min(res, f[i - 1][j - 1][1] + p[i] - p[i - 1] + 1);
                        res = min(res, f[i - 1][j - 1][3] + p[i] - p[i - 1] + 1);
                        res = min(res, f[i - 1][j - 1][4] + p[i] - p[i - 1] + 1);
                        res = min(res, f[i - 1][j - 1][5] + p[i] - p[i - 1] + 1);
                        res = min(res, f[i - 1][j - 1][7] + p[i] - p[i - 1] + 1);
                        res = min(res, f[i - 1][j - 1][8] + p[i] - p[i - 1] + 1);
                    }
                    f[i][j][3] = res;
                    
                    res = oo;
                    f[i][j][4] = res;
                    
                    res = oo;
                    f[i][j][5] = res;
                    
                    res = oo;
                    for (int r = 1; r <= 10; r++) {
                        res = min(res, f[i - 1][j - 1][r] + 2);
                    }
                    f[i][j][6] = res;
                    
                    f[i][j][7] = oo;
                    f[i][j][8] = oo;
                    
                    res = oo;
                    res = min(res, f[i - 1][j][1] + p[i] - p[i - 1]);
                    res = min(res, f[i - 1][j][3] + p[i] - p[i - 1]);
                    res = min(res, f[i - 1][j][4] + p[i] - p[i - 1]);
                    res = min(res, f[i - 1][j][5] + p[i] - p[i - 1]);
                    res = min(res, f[i - 1][j][9] + p[i] - p[i - 1]);
                    res = min(res, f[i - 1][j][10] + p[i] - p[i - 1]);
                    f[i][j][9] = res;
                    
                    
                    res = oo;
                    for (int r = 1; r <= 10; r++) {
                        res = min(res, f[i - 1][j - 1][r] + 1);
                    }
                    f[i][j][10] = res;
                }
            }
        }
    }
    
    int res = oo;
    
//    cout << f[4][2][3] << endl;
    
    for (int i = 1; i <= 10; i++) {
        res = min(res, f[cnt][k][i]);
    }
    cout << res << endl;
    
}

int main() {
//    freopen("input.txt", "r", stdin);
    
    int test;
    cin >> test;
    
    //    cout << test << endl;
    
    while (test--) {
        process();
    }
    
}

