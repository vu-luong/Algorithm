#include <iostream>
#include <list>
#include <cstring>
using namespace std;

const int n = 65;

list <int> head[n];
int cnt[n], maxc, sum, res;
bool avail[n];
string st;

inline int ID(char ch) {
    if ('a' <= ch && ch <= 'z') return ch - 'a';
    if ('A' <= ch && ch <= 'Z') return ch - 'A' + 26;
    return ch - '0' + 52;
}

void DFS(int u) {
    avail[u] = false;
    sum += cnt[u];
    for (list <int> :: iterator it = head[u].begin(); it != head[u].end(); it++) {
        int v = (int)*it;
        maxc = max(maxc, cnt[v]);
        if (avail[v]) DFS(v);
    }
}

int main() {
    getline(cin, st);
    for (int i = (st.size() - 1) / 2; i >= 0; i--) {
        int x = ID(st[i]), y = ID(st[st.size() - 1 - i]);

        ++cnt[x]; ++cnt[y];
        if (i == st.size() - 1 - i) --cnt[x];

        if (x != y) {
            head[x].push_back(y);
            head[y].push_back(x);
        }
    }

    for (int i = 0; i < n; i++) {
        head[i].sort();
        head[i].unique();
    }

    memset(avail, true, sizeof(avail));
    for (int i = 0; i < n; i++)
        if (avail[i] && head[i].size()) {
            maxc = sum = 0;
            DFS(i);
            res += sum - maxc;
        }

    printf("%d", res);
}
