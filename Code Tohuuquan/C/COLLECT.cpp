#include <iostream>
#include <vector>
#include <cstring>
#include <queue>
#include <algorithm>
using namespace std;

const int MAXZ = 6, MAXS = 6, MAXM = 6;

struct TPack {
    int z, s, m;

    TPack() {}
    TPack(int _z, int _s, int _m) {
        z = _z; s = _s; m = _m;
    }

    bool Check() {
        return z <= 4 && s <= 4 && m <= 4;
    }

    friend bool operator <= (TPack u, TPack v) {
        return u.z <= v.z && u.s <= v.s && u.m <= v.m;
    }

    friend TPack operator + (TPack u, TPack v) {
        return TPack(u.z + v.z, u.s + v.s, u.m + v.m);
    }

    friend TPack operator - (TPack u, TPack v) {
        return TPack(u.z - v.z, u.s - v.s, u.m - v.m);
    }
};

bool cmp(TPack u, TPack v) {
    if (u.z != v.z) return u.z < v.z;
    if (u.s != v.s) return u.s < v.s;
    if (u.m != v.m) return u.m < v.m;
    return false;
}

vector < pair <TPack, TPack> > c;
vector <TPack> res;
int mark[MAXZ][MAXS][MAXM];
TPack s, f;
int k;

int main() {
    scanf("%d\n", &k); ++k;
    scanf("%d %d %d %d %d %d\n", &s.z, &s.s, &s.m, &f.z, &f.s, &f.m);
    TPack ts, tf;
    while (scanf("%d %d %d %d %d %d",
                 &ts.z, &ts.s, &ts.m, &tf.z, &tf.s, &tf.m) != EOF)
        c.push_back(make_pair(ts, tf));

    queue <TPack> Q;
    Q.push(s);
    mark[s.z][s.s][s.m] = 1;
    while (Q.size()) {
        TPack u = Q.front(); Q.pop();
        for (int i = 0; i < c.size(); i++)
            if (c[i].first <= u) {
                TPack v = u - c[i].first + c[i].second;
                if (mark[v.z][v.s][v.m] == 0 && v.Check()) {
                    mark[v.z][v.s][v.m] = mark[u.z][u.s][u.m] + 1;
                    if (f <= v)
                        res.push_back(v);
                    else if (mark[v.z][v.s][v.m] < k)
                        Q.push(v);
                }
            }
    }

    if (res.size()) {
        printf("%d\n", res.size());
        sort(res.begin(), res.end(), cmp);
        for (int i = 0; i < res.size(); i++) {
            TPack t = res[i];
            printf("%d %d %d %d\n",
                   t.z, t.s, t.m, mark[t.z][t.s][t.m] - 1);
        }
    }
    else printf("-1");
}
