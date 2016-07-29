#include <iostream>
#include <cstdio>
#include <numeric>
#include <deque>
#include <algorithm>
using namespace std;

const int MAXN = 1094785;

long long a[MAXN * 2], res;
int n;

int main() {
    scanf("%d", &n);
    for (int i = 0; i < n; i++) {
        scanf("%lld", a + i);
        a[i + n] = a[i];
    }

    partial_sum(a, a + n * 2, a);
    res = a[0];

    deque <int> Q;
    for (int i = 0; i < n * 2; i++) {
        while (Q.size() && a[Q.back()] >= a[i]) Q.pop_back();
        while (Q.size() && Q.front() <= i - n) Q.pop_front();
        Q.push_back(i);
        res = max(res, a[i] - a[Q.front()]);
    }

    cout << res;
}