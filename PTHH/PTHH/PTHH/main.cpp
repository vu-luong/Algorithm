//
//  main.cpp
//  PTHH
//
//  Created by luong anh vu on 10/22/16.
//  Copyright © 2016 luong anh vu. All rights reserved.
//

#include <iostream>
#include "SparseMatrix/SparseMatrix.h"
#include "CGM.h"
#include "FEMTwoDimens.h"
#include "map"
#include "Constants.h"
#include "DevideTriangle.h"

double f(double x, double y) {
    
    return 2*x*(1 - x) + 2*y*(1 - y);
    
}

void set(bool a[10]) {
    
    a[2] = true;
}

float g(float x, float y) {
    return 1;
}

int main() {
    clock_t begin_time = clock();

    SparseMatrix<float> A(2);
    A.set(1, 1, 1);
    A.set(0, 1, 2);
    A.set(0, 2, 1);
    A.set(1, 2, 2);
    
    vector<Point2D> Omega(4);
    Omega[0] = {0, 1};
    Omega[1] = {1, 1};
    Omega[2] = {1, 0};
    Omega[3] = {0, 0};
    
    int num_layer_devide = 6;
    
    FEM(&A, f, Omega, num_layer_devide);
    
    cout << endl;
    cout << "All Times: " << float( clock () - begin_time ) /  CLOCKS_PER_SEC << endl << endl;
    
}



