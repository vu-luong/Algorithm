#include <map>
#include <set>
#include <cstdio>
#include <vector>
#include <string>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <algorithm>

#define bit(i) (1<<(i))
#define set(mask,i) (mask |= (1<<(i)))
#define get(mask,i) (mask & (1<<(i)))

using namespace std;


int main() {

    int a = 7;
    set(a, 4);
    cout << a << endl;

}
