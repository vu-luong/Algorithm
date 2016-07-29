#include <iostream>
#include <cstdio>
#include <vector>
#include <algorithm>
using namespace std;

const int oo = (int)1e9;

int GetLength(int x, int y) {
    int res = 0;
    while (x > 0 && y > 0)
        if (x > y)
            res += x / y, x %= y;
        else
            res += y / x, y %= x;

    return (x + y == 1 ? res - 1 : oo);
}

string GetString(int x, int y) {
    string res;
    while (x > 0 && y > 0)
        if (x > y)
            res += string(x / y, 'X'), x %= y;
        else
            res += string(y / x, 'Y'), y %= x;

    res.resize(res.size() - 1);
    reverse(res.begin(), res.end());
    return res;
}

int main() {
    while (true) {
        string st;
        do getline(cin, st);
        while (st != "[CASE]" && st != "[END]");

        if (st == "[END]") break;

        int x;
        scanf("%d", &x);

        vector <int> L;
        int best = oo;
        for (int y = 1; y < x; y++) {
            int t = GetLength(x, y);
            if (t < best) best = t, L.clear();
            if (t == best) L.push_back(y);
        }

        string res = GetString(x, L[0]);
        for (int i = 1; i < L.size(); i++)
            res = min(res, GetString(x, L[i]));

        puts(res.c_str());
    }
}
