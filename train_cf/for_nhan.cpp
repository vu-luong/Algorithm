#include <bits/stdc++.h>

using namespace std;

int a[4][4];

map< pair<int, int>, int> m, n, p;

int main() {

    a[1][1] = 1;
    a[2][3] = 1;
    a[3][2] = 1;
 
    cout << sizeof(a) << endl;

    m[ make_pair(1, 1)] = 1;
    m[ make_pair(2, 3) ] = 10;
    m[ make_pair(3, 2) ] = 1;


    n[{1, 1}] = 2;
    n[{2, 2}] = 3;

    map< pair<int, int>, int>::iterator it; 
    for ( it = m.begin(); it != m.end(); it++ ) { 
        cout << it->first.first << " " << it->first.second << endl;
        cout << it->second << endl;

        if (n.find(it->first) == n.end()) {
            p.insert(it->second);
        }
    }

    for (it = n.begin(); it != n.end(); it++) {
        
    }
}
