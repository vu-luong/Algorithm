#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>
#define FR(i, a, b) for(int i = a; i < b; i++)
using namespace std;

const int MAXN = 100005;

int p[MAXN], d[MAXN], a[MAXN];
bool mark[MAXN];
vector <int> b;
int n;

bool cmp(int u, int v) { return d[u] < d[v]; }

int main() {
    scanf("%d", &n);
    FR(i, 0, n) scanf("%d", p + i);
    FR(i, 0, n) scanf("%d", d + i);
    FR(i, 0, n) a[i] = i;
    sort(a, a + n, cmp);

    priority_queue < pair <int, int> > Q;
    int t = 0;
    FR(i, 0, n) {
        t += p[a[i]];
        Q.push(make_pair(p[a[i]], i));
        if (t > d[a[i]]) {
            t -= Q.top().first;
            int j = Q.top().second;
            Q.pop();
            b.push_back(a[j]);
            mark[j] = true;
        }
    }

    printf("%d\n", b.size());
    FR(i, 0, n)
        if (!mark[i]) printf("%d ", a[i] + 1);
    FR(i, 0, b.size()) printf("%d ", b[i] + 1);
}
