#include <iostream>
#include <vector>
using namespace std;

const int MAXN = (int)1e6 + 5;
const int MAXK = (int)1e5 + 5;

int a[MAXK], num[MAXN];
vector <int> res;
int n, k;

int main() {
    scanf("%d %d", &n, &k);
    for (int i = 1; i <= k; i++) {
        scanf("%d", a + i);
        ++num[a[i]];
    }

    int opp = n / 2 + 1, cnt1 = 0, cnt2 = 0;
    long long min, cost1 = 0, cost2 = 0;
    for (int i = 1; i <= k; i++)
        if (a[i] <= opp) {
            if (a[i] != 1) ++cnt1;
            cost1 += a[i] - 1;
        }
        else {
            ++cnt2;
            cost2 += n + 1 - a[i];
        }
    min = cost1 + cost2;
    res.push_back(1);

    int prev = 1;
    num[n + 1] = num[1];
    for (int i = 2; i <= n; i++) {
        cost1 += num[opp + 1] * (n / 2) - cnt1;
        cnt1 += num[opp + 1] - num[prev + 1];
        cnt2 -= num[opp + 1] - num[prev];
        cost2 += cnt2 - num[opp + 1] * ((n - 1) / 2);

        if (cost1 + cost2 < min) {
            min = cost1 + cost2;
            res.clear();
        }
        if (min == cost1 + cost2) res.push_back(i);

        opp = (opp == n ? 1 : opp + 1);
        ++prev;
    }

    printf("%lld\n%d\n", min, res.size());
    for (int i = 0; i < res.size(); i++)
        printf("%d ", res[i]);
}
