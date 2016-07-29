#include <iostream>
#include <queue>
#include <vector>
#define BIT(x) (1 << (x))
using namespace std;

struct TInfo {
    int s, x;
    vector <int> a;

    TInfo() { a.clear(); }

    TInfo(int _s, int _x) {
        s = _s; x = _x;
    }

    TInfo Change(int pos) {
        TInfo res;
        if (s & BIT(pos))
            res.s = s - BIT(pos) + BIT(x);
        else
            res.s = s;
        res.x = pos;
        res.a = a; res.a.push_back(pos);
        return res;
    }
};

queue <TInfo> Q;
vector <int> res;
int n;

inline bool C1(int a, int b) { return (a & BIT(b)) > 0; }

inline bool C0(int a, int b) { return (a & BIT(b)) == 0; }

int main() {
    scanf("%d", &n);

    int start = 0, finish = 0, m = n * 2 + 1;
    for (int i = 0; i < n; i++) {
        start += BIT(i);
        finish += BIT(m - (i + 1));
    }
    Q.push(TInfo(start, n).Change(n - 1));

    while (Q.size()) {
        TInfo u = Q.front(), v; Q.pop();
        if (u.x - 2 >= 0 && C1(u.s, u.x - 2) && C0(u.s, u.x - 1)) {
            v = u.Change(u.x - 2);
            if (v.s == finish) { res = v.a; break; }
            Q.push(v);
        }

        if (u.x - 1 >= 0 && C1(u.s, u.x - 1)) {
            v = u.Change(u.x - 1);
            if (v.s == finish) res = v.a;
            Q.push(v);
        }

        if (u.x + 1 < m && C0(u.s, u.x + 1)) {
            v = u.Change(u.x + 1);
            if (v.s == finish) { res = v.a; break; }
            Q.push(v);
        }

        if (u.x + 2 < m && C0(u.s, u.x + 2) && C1(u.s, u.x + 1)) {
            v = u.Change(u.x + 2);
            if (v.s == finish) { res = v.a; break; }
            Q.push(v);
        }
    }

    for (int i = 0; i < res.size(); i++)
        printf("%d ", res[i] + 1);
}
