#include <iostream>
#include <queue>
using namespace std;

priority_queue <int> Q;
int n, x, y, res = 0;

int main() {
    scanf("%d", &n);
    while (n--) {
        scanf("%d %d", &x, &y);
        res += x;
        Q.push(x - y);
        if (n % 2) {
            res -= Q.top();
            Q.pop();
        }
    }
    printf("%d", res);
}
