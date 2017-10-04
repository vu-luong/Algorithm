//
//  CGM.h
//  PTHH
//
//  Created by luong anh vu on 10/22/16.
//  Copyright © 2016 luong anh vu. All rights reserved.
//

#ifndef CGM_h
#define CGM_h

#include "Constants.h"
#include "cmath"
#include "map"


using namespace std;

vector<float> sub(vector<float> a, vector<float> b) {

    for (int i = 0; i < a.size(); i++) {
        a[i] = a[i] - b[i];
    }

    return a;
}

vector<float> add(vector<float> a, vector<float> b) {
    for (int i = 0; i < a.size(); i++) {
        a[i] = a[i] + b[i];
    }
    
    return a;
}

float dot(vector<float> a, vector<float> b) {
    float res = 0;
    for (int i = 0; i < a.size(); i++) {
        res = res + a[i] * b[i];
    }
    
    return res;
}

vector<float> mul(vector<float> a, float b) {
    for (int i = 0; i < a.size(); i++) {
        a[i] = a[i] * b;
    }
    
    return a;
}

void disp(vector<float> v) {
    for (int i = 0; i < v.size(); i++) {
        cout << v[i] << " ";
    }
    
    cout << endl;
}


vector<float> CGM(SparseMatrix<float> *A, vector<float> b) {
    
    vector<float> x(b.size());

    vector<float> r = sub(b, A->multiply(x));
    
    vector<float> p = r;
    
    float rsOld = dot(r, r);
    
    vector<float> Ap = A->multiply(p);
    
    for (int i = 1; i <= b.size(); i++) {
//        cout << i << endl;
        Ap = A->multiply(p);
        
        float alpha = rsOld / dot(p, Ap);
        x = add(x, mul(p, alpha));
        r = sub(r, mul(Ap, alpha));
        float rsNew = dot(r, r);
        
        if (sqrt(rsNew) < 1e-10) break;
        
        p = add(r, mul(p, rsNew/rsOld));
        rsOld = rsNew;
    }
    
    return x;
}

vector<float> mul(map<pair<int, int>, float> &A, vector<float> &b) {
    
    vector<float> result(b.size(), 0);
    
    for (map<pair<int, int>, float>::iterator it = A.begin(); it != A.end(); ++it) {
        //        cout << it->first.x << ", " << it->first.y << " => " << it->second << endl;
//        int index = it->second;
//        if (!is_in_bound_tmp[index]) {
//            n_in++;
//            ax[index] = n_in;
//        }
        
        int x = it->first.first;
        int y = it->first.second;
        float val = it->second;
        
        result[x - 1] += val * b[y - 1];
    }

    return result;
}


vector<float> mul(data A[], vector<float> &b, int size) {
    
    vector<float> result(b.size(), 0);
    
    for (int i = 1; i <= size; i++) {
        
        int x = A[i].x;
        int y = A[i].y;
        float val = A[i].value;
        
        result[x - 1] += val * b[y - 1];
    }
    
    return result;
}

vector<float> CGM(map<pair<int, int>, float> &A, vector<float> &b) {
    
//    cout << "map size: " << A.size() << endl;
    
    int cnt = 0;
    for (map<pair<int, int>, float>::iterator it = A.begin(); it != A.end(); ) {
//        int x = it->first.first;
//        int y = it->first.second;
        float val = it->second;
        
        if (abs(val) < 1e-8) {
            it = A.erase(it);
            cnt++;
        } else {
            it++;
        }
    }
    
    
    cout << "map size after reduce: " << A.size() << endl;
    
    vector<float> x(b.size());
    
    vector<float> r = sub(b, mul(A,x));
    
    vector<float> p = r;
    
    float rsOld = dot(r, r);
    
    vector<float> Ap;// = mul(A,p);
    
    int dem = 0;
    for (int i = 1; i <= b.size(); i++) {
        dem++;
        //        cout << i << endl;
        Ap = mul(A,p);
        
        float alpha = rsOld / dot(p, Ap);
        x = add(x, mul(p, alpha));
        r = sub(r, mul(Ap, alpha));
        float rsNew = dot(r, r);
        
        if (sqrt(rsNew) < 1e-10) break;
        
        p = add(r, mul(p, rsNew/rsOld));
        rsOld = rsNew;
    }
    
    cout << "CGM Loops: " << dem << endl;
    
    return x;
}

vector<float> CGM(data A[], vector<float> &b, int size) {
    
    //    cout << "map size: " << A.size() << endl;
    
    int cnt = 0;
//    for (map<pair<int, int>, float>::iterator it = A.begin(); it != A.end(); ) {
//        //        int x = it->first.first;
//        //        int y = it->first.second;
//        float val = it->second;
//        
//        if (abs(val) < 1e-8) {
//            it = A.erase(it);
//            cnt++;
//        } else {
//            it++;
//        }
//    }
    
    
    cout << "Size after reduce: " << size << endl;
    
    vector<float> x(b.size());
    
    vector<float> r = sub(b, mul(A, x, size));
    
    vector<float> p = r;
    
    float rsOld = dot(r, r);
    
    vector<float> Ap;// = mul(A,p);
    
    int dem = 0;
    for (int i = 1; i <= b.size(); i++) {
        dem++;
        //        cout << i << endl;
        Ap = mul(A, p, size);
        
        float alpha = rsOld / dot(p, Ap);
        x = add(x, mul(p, alpha));
        r = sub(r, mul(Ap, alpha));
        float rsNew = dot(r, r);
        
        if (sqrt(rsNew) < 1e-10) break;
        
        p = add(r, mul(p, rsNew/rsOld));
        rsOld = rsNew;
    }
    
    cout << "CGM Loops: " << dem << endl;
    
    return x;
}



#endif /* CGM_h */
