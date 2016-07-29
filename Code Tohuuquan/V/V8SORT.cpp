#include <iostream>
#include <sstream>
#include <queue>
#include <cstring>
#include <algorithm>
using namespace std;

const int MAXN = 7, MAXM = 5045, MAXD = MAXM * 1000;
const int f[] = { 1, 1, 2, 6, 24, 120, 720, 5040 };

typedef pair <int, int> TPair;

int a[MAXN], c[MAXN][MAXN], d[MAXM];
bool avail[MAXM];
queue <TPair> Q;
int n, finish;

void Enter() {
    string st; getline(cin, st);
    stringstream ss; ss << st;
    while (ss >> a[n]) ++n;
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++) scanf("%d", &c[i][j]);
}

int Encrypt(vector <int> a) {
    int res = 1;
    for (int i = 0; i < n; i++) {
        int cnt = 0;
        for (int j = 0; j < i; j++)
            if (a[i] > a[j]) ++cnt;
        res += f[n - i - 1] * (a[i] - cnt);
    }
    return res;
}

vector <int> Unencrypt(int id) {
    vector <int> res;
    vector <bool> fr(n, true);
    for (int i = 0; i < n; i++) {
        int j;
        for (j = 0; j < n; j++)
            if (fr[j])
                if (id > f[n - i - 1]) id -= f[n - i - 1];
                else break;
        res.push_back(j == n ? n - 1 : j);
        fr[j] = false;
    }
    return res;
}

bool cmp(int u, int v) { return a[u] < a[v]; }

void Init() {
    vector <int> id;
    for (int i = 0; i < n; i++) id.push_back(i);
    sort(id.begin(), id.end(), cmp);
    finish = Encrypt(id);
}

void Solve() {
    priority_queue < TPair, vector <TPair>, greater <TPair> > Q;
    for (int v = 1; v <= f[n]; v++) d[v] = MAXD;
    memset(avail, true, sizeof(avail));
    d[1] = 0;
    Q.push(make_pair(d[1], 1));

    while (Q.size()) {
        TPair u = Q.top(); Q.pop();
        if (!avail[u.second]) continue;
        if (u.second == finish) break;
        avail[u.second] = false;

        vector <int> u_a = Unencrypt(u.second);
        for (int i = 0; i < n - 1; i++)
            for (int j = i + 1; j < n; j++) {
                vector <int> v_a(u_a);
                swap(v_a[i], v_a[j]);
                int v_id = Encrypt(v_a);

                if (avail[v_id] && d[v_id] > u.first + c[i][j]) {
                    d[v_id] = u.first + c[i][j];
                    Q.push(make_pair(d[v_id], v_id));
                }
            }
    }
}

void Print() {
    printf("%d", d[finish]);
}

int main() {
    Enter();
    Init();
    Solve();
    Print();
}
