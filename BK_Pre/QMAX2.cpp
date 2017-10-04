#include<bits/stdc++.h>

using namespace std;

const int MAXN = (int) 5e4 + 5;

int Tree[MAXN*8], T[MAXN*8];
int m, n;
int res;

void update(int x, int l, int r, int u, int v, int value) {

    if (T[x] > 0) {
        T[x * 2] += T[x];
        T[x * 2 + 1] += T[x];
        Tree[x] += T[x];
        T[x] = 0;
    }
    if (r < u || l > v) return;
    if (u <= l && r <= v) {
        T[x * 2] += value;
        T[x * 2 + 1] += value;
        Tree[x] += value;
        T[x] = 0;
    }
    int mid = (l + r) / 2;
    update(x * 2, l, mid, u, v);
    update(x * 2 + 1, mid + 1, r, u, v);
    Tree[x] = max(Tree[x * 2], Tree[x * 2 + 1]);
}

void getmax(int x, int l, int r, int u, int v) {
    if (T[x] > 0) {
        T[x * 2] += T[x];
        T[x * 2 + 1] += T[x];
        Tree[x] += T[x];
        T[x] = 0;
    }

    if (r < u || l > v) return;

    if (u <= l && r <= v) {
        if (res < Tree[x]) {
            res = Tree[x];
        }
        return;
    }
    int mid = (l + r) / 2;

    getmax(x * 2, l, mid, u, v);
    getmax(x * 2 + 1, mid + 1, r, u, v);

    Tree[x] = max(Tree[x * 2], Tree[x * 2 + 1]);

}

int main() {
    freopen("QMAX2.txt", "r", stdin);
    scanf("%d %d", &n, &m);

    for (int i = 1; i <= m; i++) {
        int type;
        scanf("%d", &type);
        
        if (type == 0) {
            int u, v, value;
            scanf("%d %d %d", &u, &v, &value);
            update(1, 1, n, u, v, value);
        } else {
            int u, v;
            res = -1;
            scanf("%d %d", &u, &v);
            getmax(1, 1, n, u, v);
            cout << res << endl;
        }

    }
}
