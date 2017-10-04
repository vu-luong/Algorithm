#include <cstdio>
#include <iostream>
#include <cstdlib>
#include <cstring>

using namespace std;

#define TMAX 105
#define NMAX 1005

int main(){
  int T, N;
  int i;
  int height[NMAX], pos[NMAX];
  cin >> T;
  while (T > 0){
    cin >> N;
    for (i = 0; i < N; i++)
      cin >> height[i];
    for (i = 0; i < N; i++)
      cin >> pos[i];
    for (i = 0; i < N; i++)
      cout << height[i] << endl;
    T -= 1;
  }
  return 0;
}
