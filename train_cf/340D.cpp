#include <bits/stdc++.h>

using namespace std;

const int MAXN = (int) 1e5 + 5;
int n;
int a[MAXN], f[MAXN], l[MAXN];

int main(){
    scanf("%d", &n);
    for (int i = 1; i <= n; i++) {
        scanf("%d", &a[i]);
    }

    f[1] = 1;
    l[1] = 1;
    int count = 1;
    for (int i = 2; i <= n; i++) {
        if (a[i] > a[l[count]]) {
            count++;
            l[count] = i;
        } else 
            if (a[i] < a[l[1]]) {
                l[1] = i;
            } else {
                int dau = 0;
                int cuoi = count + 1;
                int giua;
                while (dau + 1 < cuoi) {
                    giua = (dau + cuoi) / 2;
                    if (a[l[giua]] >= a[i]) cuoi = giua;
                    else dau = giua;
                }

                l[cuoi] = i;
            }
    }
    printf("%d", count);
}

