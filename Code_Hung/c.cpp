
#include<iostream>
#include<cmath>


using namespace std;

int main() {

    int a, b, c;

    cin >> a >> b >> c;

    float s = sqrt((a + b + c)*(a + b - c)*(b + c - a)*(c + a - b)) / 4;

    printf("%0.13f", s);

}
