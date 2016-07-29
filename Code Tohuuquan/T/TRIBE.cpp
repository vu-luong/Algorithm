#include <iostream>
#include <algorithm>
#include <vector>
#include <sstream>
#define FR(i, a, b) for(int i = a; i < b; i++)
#define FOR(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

const int MAXN = 55;
const int MAXX = 55, MAXY = 55, MAXZ = 55;

struct TInfo {
    string s;
    int na, nb, v;
};

TInfo a[MAXN];
int f[MAXX][MAXY][MAXZ], t[MAXX][MAXY][MAXZ];
int n, x, y, z;
int maxf = 0, rx, ry, rz;

bool cmp(TInfo u, TInfo v) {
    return u.s < v.s;
}

int main() {
    string st;
    scanf("%d", &n);               getline(cin, st);
    scanf("%d %d %d", &x, &y, &z); getline(cin, st);
    FR(i, 0, n) {
        getline(cin, st);
        int j;
        for (j = 0; j < st.length(); j++) {
            if (st[j] == ' ') break;
            a[i].s += st[j];
            if (st[j] == 'a') ++a[i].na; else ++a[i].nb;
        }
        stringstream ss;
        while (++j < st.length()) ss << st[j];
        ss >> a[i].v;
    }

    sort(a, a + n, cmp);

    FR(i, 0, n) {
        int jx, jy;
        jx = a[i].na;
        jy = a[i].nb;
        if (f[jx][jy][0] < a[i].v) {
            f[jx][jy][0] = a[i].v;
            t[jx][jy][0] = i;
        }
    }
    FOR(ix, 0, x) FOR(iy, 0, y) FOR(iz, 1, z){
        FR(i, 0, n) {
            int jx, jy, jz;
            jx = ix - a[i].na;
            jy = iy - a[i].nb;
            jz = iz - 1;

            if (jx < 0 || jy < 0 || f[jx][jy][jz] == 0) continue;

            if (f[jx][jy][jz] + a[i].v > f[ix][iy][iz]) {
                f[ix][iy][iz] = f[jx][jy][jz] + a[i].v;
                t[ix][iy][iz] = i;
            }
        }

        if (f[ix][iy][iz] >= maxf) {
            maxf = f[ix][iy][iz];
            rx = ix; ry = iy; rz = iz;
        }
    }

    vector <int> res;
    while (rz >= 0) {
        int i = t[rx][ry][rz];
        res.push_back(i);
        rx -= a[i].na;
        ry -= a[i].nb;
        --rz;
    }

    sort(res.begin(), res.end());

    cout << a[res[0]].s;
    FR(i, 1, res.size())
        cout << " " << a[res[i]].s;
}
