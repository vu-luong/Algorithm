#include<bits/stdc++.h>


using namespace std;
const int MAXN = 100005;
const int inf = (int) 1e9 + 7;

int ns, n;
pair <long long, int> s[MAXN], l[MAXN],  r[MAXN];
vector< long long > adj[MAXN];
int dis[MAXN], matchX[MAXN], matchY[MAXN];
long long save[MAXN];
queue<int> q;

bool findpath() {

    for (int i = 1; i <= n; i++) {
        if (matchX[i] == 0) {
            dis[i] = 0;
            q.push(i);
        } else dis[i] = inf;
    }

    dis[0] = inf;

    while (!q.empty()) {
        int u = q.front();
        q.pop();
        for (int i = 0; i < adj[u].size(); i++) {
            int v = adj[u][i];
            if (dis[matchY[v]] == inf) {
                dis[matchY[v]] = dis[u] + 1;
                if (matchY[v] != 0) {
                    q.push(matchY[v]);
                }
            }
        }
    }

    return dis[0] != inf;
}

bool dfs(int u) {
    if (u == 0) return true;
    for (int i = 0; i < adj[u].size(); i++){
        int v = adj[u][i];
        if (dis[matchY[v]] == dis[u] + 1) {
            if (dfs(matchY[v])) {
                matchX[u] = v;
                matchY[v] = u;
                return true;
            }
        }
    }
    dis[u] = inf;
    return false;
}


int main() {
    //freopen("E.txt", "r", stdin);
    scanf("%d", &n);

    ns = 0;
    for (int i = 1; i <= n; i++) {
        int u, v;
        scanf("%d %d", &u, &v);
        l[i] = {u, v};

        ns++;
        s[ns] = {u - v, i};
        ns++;
        s[ns] = {u + v, i};
        ns++;
        s[ns] = {1ll* u * v, i};
    }

 //   for (int i = 1; i <= ns; i++) {
 //       cout << s[i].first << " " << s[i].second << endl;
 //   }

    sort(s + 1, s + 1 + ns);

    int cnt = 1;
    r[1] = {1, s[1].second};
    save[1] = s[1].first;
    for (int i = 2; i <= ns; i++) {
        if (s[i].first == s[i - 1].first) {
            r[i] = {cnt, s[i].second};
        } else {
            cnt++;
            r[i] = {cnt, s[i].second};
            save[cnt] = s[i].first;
        }
    }

    for (int i = 1; i <= ns; i++) {
        int u = r[i].second;
        int v = r[i].first;
        adj[u].push_back(v);
    }

    memset(matchX, 0, sizeof(matchX));
    memset(matchY, 0, sizeof(matchY));

    int res = 0;

    while (findpath()) {
        for (int i = 1; i <= n; i++) {
            if (matchX[i] == 0) {
                if (dfs(i)) res++;
            }
        }
    }

    if (res == n) {
        for (int i = 1; i <= n; i++) {
            
            int u = matchX[i];
            long long v = save[u];

            int v1 = l[i].first;
            int v2 = l[i].second;
            if (v1 + v2 == v) {
                cout << v1 << " + " << v2 << " = " << v << endl;
            } else
            if (v1 - v2 == v) {
                cout << v1 << " - " << v2 << " = " << v << endl;
            } else {
                cout << v1 << " * " << v2 << " = " << v << endl;
            }
        }
    } else {
        cout << "impossible";
    }


}
