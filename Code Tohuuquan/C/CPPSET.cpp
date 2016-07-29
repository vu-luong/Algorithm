#include <iostream>
#include <set>
using namespace std;

set <int> S;
int x, n;

int main() {
    while (true) {
        scanf("%d", &x);
        if (x == 0) break;
        switch(x) {
            case 1 :
                scanf("%d", &n);
                S.insert(n);
                break;
            case 2 :
                scanf("%d", &n);
                if (S.count(n) > 0) S.erase(S.find(n));
                break;
            case 3 :
                if (S.size()) printf("%d\n", *S.begin());
                else printf("empty\n");
                break;
            case 4 :
                if (S.size()) printf("%d\n", *S.rbegin());
                else printf("empty\n");
                break;
            case 5 :
                scanf("%d", &n);
                if (S.size()) {
                    if (*S.rbegin() <= n) printf("no\n");
                    else printf("%d\n", *S.upper_bound(n));
                }
                else printf("empty\n");
                break;
            case 6 :
                scanf("%d", &n);
                if (S.size()) {
                    if (*S.rbegin() < n) printf("no\n");
                    else if (S.count(n) > 0) printf("%d\n", n);
                    else printf("%d\n", *S.upper_bound(n));
                }
                else printf("empty\n");
                break;
            case 7 :
                scanf("%d", &n);
                if (S.size()) {
                    if (*S.begin() >= n) printf("no\n");
                    else printf("%d\n", *(--S.lower_bound(n)));
                }
                else printf("empty\n");
                break;
            case 8 :
                scanf("%d", &n);
                if (S.size()) {
                    if (*S.begin() > n) printf("no\n");
                    else if (S.count(n) > 0) printf("%d\n", n);
                    else printf("%d\n", *(--S.lower_bound(n)));
                }
                else printf("empty\n");
                break;
        }
    }
}
