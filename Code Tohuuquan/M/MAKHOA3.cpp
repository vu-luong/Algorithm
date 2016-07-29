#include <iostream>
#include <cstdio>
#include <vector>

#define FOR(i, a, b) for(int i = a; i <= b; i++)
#define RP(i, n)     for(int i = 0; i < n; i++)

using namespace std;

const int MAX = 35;

vector <int> arow[MAX], acol[MAX];
vector <int> brow[MAX], bcol[MAX];
char c[MAX][MAX];
int n, m, t;

inline bool OK(char ch) {
    return (ch == '0') || (ch == '1');
}

bool Check() {
    FOR(i, 1, m) {
        brow[i].clear();
        int cnt = 0;
        FOR(j, 1, n + 1)
            if (c[i][j] == '1') ++cnt;
            else if (cnt) {
                brow[i].push_back(cnt);
                cnt = 0;
            }
    }
    FOR(j, 1, n) {
        bcol[j].clear();
        int cnt = 0;
        FOR(i, 1, m + 1)
            if (c[i][j] == '1') ++cnt;
            else if (cnt) {
                bcol[j].push_back(cnt);
                cnt = 0;
            }
    }

    FOR(i, 1, m)
        if (arow[i] != brow[i]) return false;
    FOR(j, 1, n)
        if (acol[j] != bcol[j]) return false;

    return true;
}

int main() {
    scanf("%d %d", &m, &n);
    FOR(i, 1, m) {
        int x; scanf("%d", &x);
        arow[i].resize(x);
        RP(j, x) scanf("%d", &arow[i][j]);
    }
    FOR(i, 1, n) {
        int x; scanf("%d", &x);
        acol[i].resize(x);
        RP(j, x) scanf("%d", &acol[i][j]);
    }

    scanf("%d", &t);
    while (t--) {
        FOR(i, 1, m) FOR(j, 1, n) {
            char &ch = c[i][j];
            do ch = getchar(); while (!OK(ch));
        }
        FOR(i, 1, m) c[i][n + 1] = '0';
        FOR(j, 1, n) c[m + 1][j] = '0';

        puts(Check() ? "YES" : "NO");
    }
}