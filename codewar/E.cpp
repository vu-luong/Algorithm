//
//  main.cpp
//  E
//
//  Created by luong anh vu on 11/13/16.
//  Copyright © 2016 luong anh vu. All rights reserved.
//

#include <iostream>
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

using namespace std;

const int N = 10;
const int M = 15;
int x[20];
bool fr[20];
int a[15], b[15], c[15];
bool ok;
bool check() {
    
//    for (int i = 1; i <= M; i++) {
//        cout << x[i] << " ";
//    }
//    
//    cout << endl;

    
    for (int i = 1; i <= N; i++) {
        int i1 = a[i];
        int i2 = b[i];
        int i3 = c[i];
        
        int v1 = x[i1];
        int v2 = x[i2];
        int v3 = x[i3];
        
        int m = max(v1, max(v2, v3));
        
        if (v1 == m || v1 + v2 + v3 != 2*m) {
            return false;
        }
    }
    
    return true;
}

void rec(int u) {
    if (u == M + 1) {
        if (!check()) return;
        for (int i = 1; i <= M; i++) {
            cout << x[i] << " ";
        }
        ok = true;
        cout << endl;
        return;
    }
    
    if (ok) return;
    
    for (int j = 1; j <= M; j++) {
        if (fr[j]) {
            x[u] = j;
            fr[j] = false;
            rec(u + 1);
            fr[j] = true;
        }
    }
    
}

int main() {
    freopen("E.txt", "r", stdin);
    
    for (int i = 1; i <= N; i++) {
        cin >> a[i] >> b[i] >> c[i];
        a[i]++;
        b[i]++;
        c[i]++;
    }
    
    ok = false;
    
    memset(fr, true, sizeof(fr));
//    x[1] = 1;
//    x[2] = 10;
//    x[3] = 11;
//    x[4] = 10;
//    x[5] = 4;
//    fr[1] = false;
//    fr[10] = false;
//    fr[11] = false;
//    fr[10] = false;
//    fr[4] = false;
    
    rec(1);
    
    cout << "END" << endl;
    
    
}
