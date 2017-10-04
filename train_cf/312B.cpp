#include <bits/stdc++.h>

using namespace std;

int a, b, c, d;
int main(){

    cin >> a >> b >> c >> d;

    double k = (b - a)*(d - c)*1.0f/(b*d);

    double res = a * 1.0f / (b*(1 - k));

    printf("%0.9f\n", res);


}
