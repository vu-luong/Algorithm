#include <iostream>
#include <vector>
#include <algorithm>
#include <sstream>
using namespace std;

const int MAXN = 410;

vector <int> c[MAXN];
int f[MAXN];
int n;

bool cmp(int x, int y) { return x > y; }

void Visit(int u) {
    if (c[u].size() == 0) {
        f[u] = 1;
        return;
    }
    f[u] = c[u].size();
    vector <int> a;
    for (int i = 0; i < c[u].size(); i++) {
        int v = c[u][i];
        Visit(v);
        a.push_back(f[v]);
    }
    sort(a.begin(), a.end(), cmp);
    for (int i = 0; i < a.size(); i++)
        f[u] = max(f[u], a[i] + i);
}

int main() {
    scanf("%d\n", &n);
    string st;
    while (getline(cin, st)) {
        stringstream ss; ss << st;
        int x, m; ss >> x >> m;
        for (int i = 0; i < m; i++) {
            int y; ss >> y;
            c[x].push_back(y);
        }
    }

    Visit(1);
    printf("%d", f[1]);
}
