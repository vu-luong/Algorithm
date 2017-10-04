#define DEBUG(x) cout << #x << " = " << x << endl
#include <map>
#include <set>
#include <cmath>
#include <cstdio>
#include <vector>
#include <string>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <algorithm>
#include <queue>
#include <unordered_map>

using namespace std;
int hv(vector<int> &v) {
    int r = 0, b = 1;
    for (auto x: v) {
        r += x * b;
        b = b * 50;
    }
    return r;
}
int t, n, x;
int main() {
    freopen("CTAIN.txt", "r", stdin);
    cin >> t;
    while (t--) {
        cin >> n;
        vector<int> c, d;
        for (int i = 1; i <= n; i++) {
            cin >> x;
            c.push_back(x);
        }
        for (int i = 1; i <= n; i++) {
            cin >> x;
            d.push_back(x);
        }
        queue<vector<int>> q; q.push(c);
        unordered_map<int, int> dst; dst.insert({hv(c), 0});
        bool ok = false;
        int r = 0;

        while (!q.empty()) {
            vector<int> s = q.front();
            q.pop();
            if (hv(s) == hv(d)) {
                r = dst[hv(s)];
                ok = true;
                break;
            }

            // empty one
            for (int i = 0; i < s.size(); i++) {
                vector<int> ns(s);
                ns[i] = 0;
                if (dst.find(hv(ns)) == dst.end()) {
                    dst[hv(ns)] = dst[hv(s)] + 1;
                    q.push(ns);
                }
            }

            // pour from one to other
            for (int i = 0; i < s.size(); i++) {
                for (int j = 0; j < s.size(); j++) {
                    if (i != j) {
                        vector<int> ns(s);
                        int am = min(c[j] - s[j], s[i]);
                        ns[j] = ns[j] + am;
                        ns[i] = ns[i] - am;
                        if (dst.find(hv(ns)) == dst.end()) {
                            dst[hv(ns)] = dst[hv(s)] + 1;
                            q.push(ns);
                        }
                    }
                }
            }

        }

        if (ok) {
            cout << r << endl;
        } else {
            cout << "NO" << endl;
        }
    }
}

