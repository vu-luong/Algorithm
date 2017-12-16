#include <bits/stdc++.h>

#define ff(i, a, b) for(int i=(a); (i <= (b)); ++i)
#define FF(i, a, b) for(int i=(a); (i >= (b)); --i)
#define fin( v , a ) for(auto v : a )
#define ll long long
#define random(a, b) (rand() % (b - a + 1) + a)
#define pi 3.141592653589793238462643383279502884
#define INRA(a,u,v) {cout << "_\n"; ff(i,u,v) cout << a[i].x << " " << a[i].y << endl; cout << "|\n";}
#define pb push_back
#define mp make_pair
#define y1 ahsclskajlasjdkl
#define x1 akjadhaskdals

template<class X, class Y>
void minimize(X &a, const Y &b) {
    if (b<a) a = b;
}

template<class X, class Y>
void maximize(X &a, const Y &b) {
    if (a<b) a = b;
}

const int M = 1000000000+7;
const int MN = 500000+10;

using namespace std;

struct re {
    int x, y;
    re () {};
    re (int X, int Y) {x = X; y = Y;};
    /*const bool operator < (const re &a) const{
        if (x!=a.x) return x<a.x;
        return y<a.y;
    }*/
};

int n, e[MN][2], q[MN], top, bot = 1, a[MN], kt[MN], deg[MN];
ll m, f[MN];
char t[MN];

int main() {
    ios_base::sync_with_stdio(false); cin.tie(0);
    //freopen("checking.inp", "r" , stdin);
    //freopen("checking.out", "w", stdout);
    cin >> m >> n;
    ff(i,1,n) {
        cin >> t[i] >> e[i][0] >> e[i][1];
        deg[e[i][0]]++;
        deg[e[i][1]]++;
        if (t[i] == 'L') a[i] = 0; else a[i] = 1;
    }

    f[1] = m;

    q[++top] = 1;
    while (bot<=top) {
        int u = q[bot++];
        kt[u] = a[u]^(f[u]%2);
        ff(i,0,1) {
            int v = e[u][i];
            f[v] += (f[u]+(a[u]==i))/2;
            //cout << u << " " << v << " " << (f[u]+(a[u]==i))/2<<endl;
            deg[v]--;
            if (deg[v] == 0) q[++top] = v;
        }
    }

    ff(i,1,n) {
        //cout << i << " " << f[i] << endl;
        if (kt[i]) cout << "R"; else cout << "L";
    }
}
//This code belongs to S34vv1nd :3
