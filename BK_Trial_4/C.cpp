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

#define PB push_back
#define MP make_pair
#define SZ(a) a.size()
#define DEBUG(x) cout << #x << " = " << x << endl;

#define PR(A,n)  { cout << #A << " = "; for (int i = 1, _n = (n); i <= _n; i++) \
                    cout << A[i] << ' '; cout << endl; }
#define PR0(A,n) { cout << #A << " = "; for (int i = 0, _n = (n); i < _n; i++) \
                    cout << A[i] << ' '; cout << endl; }

using namespace std;

int n;
double a, b;
const double eps = 1e-15;
double A[2000], B[2000];

double maxx(double a, double b) {
    if (a-b > eps) return a;
    else return b;
}

int main() {
    // freopen("C.txt", "r", stdin);
    int i;
	int minA1 = 1 , minA2 = 1, minB1 = 1, minB2 = 1;
    A[0] = 1e15;
    B[0] = 1e15;

	cin >> n >> a >> b;
	for (i=1; i<=n; i++) scanf("%lf %lf", &A[i], &B[i]);

	for (i=1; i<=n; i++)
	 {
	 	if (A[i] < A[minA1]) minA1 = i;
	 	if (B[i] < B[minB1]) minB1 = i;
	 }

     if (n == 1)
 	 {
         double x1 = a/A[minA1];
         double x2 = b/B[minB1];
 	 	printf("%.6lf", maxx(x1, x2));
        return 0;
 	 }

	for (i=1; i<=n; i++)
	 {
	 	if (i!=minA1) if (A[i] < A[minA2]) minA2 = i;
	 	if (i!=minB1) if (B[i] < B[minB2]) minB2 = i;
	 }

     double x1 = a/A[minA1];
     double x2 = b/B[minB1];


 	if (minA1 != minB1) printf("%.6lf", x1 + x2);
    else {
         double x3 = b/B[minB2];
         double x4 = a/B[minA2];
         printf("%.6lf", maxx(x1 + x3,x2 +x4));
    }

	return 0;
}
