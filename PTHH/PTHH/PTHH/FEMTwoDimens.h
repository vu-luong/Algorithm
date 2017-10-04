//
//  FEMTwoDimens.h
//  PTHH
//
//  Created by luong anh vu on 10/22/16.
//  Copyright © 2016 luong anh vu. All rights reserved.
//

#ifndef FEMTwoDimens_h
#define FEMTwoDimens_h
#define PB push_back
#define MP make_pair


#include "SparseMatrix/SparseMatrix.h"

#include "Constants.h"
#include "map"
#include "DevideTriangle.h"
#include "CGM.h"

using namespace std;

int map_local_to_global[MAXM][4];
bool is_in_bound_tmp[MAXM];
bool is_in_bound[MAXM];
float S_triangles[MAXM];
int ax[MAXM];
map<Point2D, int, Point2DCompare> index_points_map;
data B_CGM[12000000];


void disp(SparseMatrix<float> *SM, int n) {
    cout << "SM = \n";
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            cout << SM->get(i, j) << " ";
        }
        cout << endl;
    }
}

float det3(float a[4][4]) {
    float tmp1 = a[1][1]*a[2][2]*a[3][3] + a[1][2]*a[2][3]*a[3][1] + a[1][3]*a[2][1]*a[3][2];
    float tmp2 = (a[1][3]*a[2][2]*a[3][1] + a[1][1]*a[2][3]*a[3][2] + a[1][2]*a[2][1]*a[3][3]);
    return tmp1 - tmp2;
}

vector<float> solve(SparseMatrix<float> *A, vector<float> b) {
    
    float a[4][4];
    for (int i = 1; i <= 3; i++){
        for (int j = 1; j <= 3; j++) {
            a[i][j] = A->get(i, j);
        }
    }
    
    float D = det3(a);
    
    for (int i = 1; i <= 3; i++){
        a[i][1] = b[i - 1];
        for (int j = 2; j <= 3; j++) {
            a[i][j] = A->get(i, j);
        }
    }
    
    float Dx = det3(a);
    
    for (int i = 1; i <= 3; i++){
        a[i][1] = A->get(i, 1);
        a[i][2] = b[i - 1];
        a[i][3] = A->get(i, 3);
    }
    
    float Dy = det3(a);
    
    for (int i = 1; i <= 3; i++){
        a[i][1] = A->get(i, 1);
        a[i][2] = A->get(i, 2);
        a[i][3] = b[i - 1];
    }
    
    float Dz = det3(a);
    
    return {Dx/D, Dy/D, Dz/D};
    
}


void FEM(SparseMatrix<float> *A, function<double (double, double)> f, vector<Point2D> Omega, int n_layer_devide) {
    
    cout << "Buoc 1: Chia mien Omega thanh cac tam giac\n";
    
    clock_t begin_time = clock();
    
    int num_points_Omega = Omega.size();
    
    Point2D coor_inside_point = {0, 0};
    
    for (int i = 0; i < num_points_Omega; i++) {
        coor_inside_point.x += Omega[i].x / num_points_Omega;
        coor_inside_point.y += Omega[i].y / num_points_Omega;
    }

    vector<Triangle> tris;
    
    for (int i = 0; i < num_points_Omega - 1; i++) {
        Triangle tri = {
            Omega[i],
            coor_inside_point,
            Omega[i + 1]
        };
        
        tris.push_back(tri);
        map_local_to_global[i][1] = i;
        map_local_to_global[i][2] = num_points_Omega;
        map_local_to_global[i][3] = i + 1;
    }

    Triangle tri = {
        Omega[num_points_Omega - 1],
        coor_inside_point,
        Omega[0]
    };
    tris.push_back(tri);
    
    map_local_to_global[num_points_Omega - 1][1] = num_points_Omega - 1;
    map_local_to_global[num_points_Omega - 1][2] = num_points_Omega;
    map_local_to_global[num_points_Omega - 1][3] = 0;
    
//    Danh so thu tu cac dinh bang map
//    Luu toa do dinh vao points_global

    memset(is_in_bound_tmp, false, sizeof(is_in_bound_tmp));
    
    for (int i = 0; i < num_points_Omega; i++) {
        
        Point2D p = Omega[i];
        index_points_map[p] = i;
//        points_global[i] = p;
        is_in_bound_tmp[i] = true;
    }

    index_points_map[coor_inside_point] = num_points_Omega;
    is_in_bound_tmp[num_points_Omega] = false;
    
    
    for (int i = 1; i <= n_layer_devide; i++) {
        devide(tris, index_points_map, is_in_bound_tmp, map_local_to_global);
    }
    
    cout << "tris.size() = " <<  tris.size() << endl;
    
//    for (int i = 0; i < tris.size(); i++) {
//        Triangle tri = tris[i];
//        cout << i << ":" << endl;
//        cout << tri.p1.x << " " << tri.p1.y << endl;
//        cout << tri.p2.x << " " << tri.p2.y << endl;
//        cout << tri.p3.x << " " << tri.p3.y << endl;
//    }

//    cout << map_local_to_global[5][1] << endl;
//    cout << map_local_to_global[4][2] << endl;
    
    int n_in = -1;
    for (map<Point2D, int, Point2DCompare>::iterator it = index_points_map.begin();
         it != index_points_map.end(); ++it) {
//        cout << it->first.x << ", " << it->first.y << " => " << it->second << endl;
        int index = it->second;
        if (!is_in_bound_tmp[index]) {
            n_in++;
            ax[index] = n_in;
        }
    }
    
    int n_all = n_in;
    
    for (map<Point2D, int, Point2DCompare>::iterator it = index_points_map.begin();
         it != index_points_map.end(); ++it) {
        int index = it->second;
        if (is_in_bound_tmp[index]) {
            n_all++;
            ax[index] = n_all;
        }
    }
    
    for (map<Point2D, int, Point2DCompare>::iterator it = index_points_map.begin();
         it != index_points_map.end(); ++it) {
        int index = it->second;
        int new_id = ax[index];
        
        index_points_map[it->first] = new_id;
        is_in_bound[new_id] = is_in_bound_tmp[index];
    }
    
    for (int i = 0; i < tris.size(); i++) {
        for (int j = 1; j <= 3; j++) {
            int index = map_local_to_global[i][j];
            int new_id = ax[index];
            map_local_to_global[i][j] = new_id;
        }
    }
//    
//    for (map<Point2D, int, Point2DCompare>::iterator it = index_points_map.begin();
//         it != index_points_map.end(); ++it) {
//        
//        cout << it->first.x << ", " << it->first.y << " => " << it->second
//            << "--> in bound: " << is_in_bound[it->second] << endl;
//    }
    cout << "Times: " << float( clock () - begin_time ) /  CLOCKS_PER_SEC << endl << endl;
    begin_time = clock();
    
//     Buoc 2: Tinh ma tran F
    
    cout << "Buoc 2: Tinh ma tran F\n";
    
//    float F[MAXM];
    vector<float> F(n_in + 1);
    
//    memset(F, 0, sizeof(F));
    
    for (int k = 0; k < tris.size(); k++) {
        Point2D p1 = tris[k].p1;
        Point2D p2 = tris[k].p2;
        Point2D p3 = tris[k].p3;
        int k1 = map_local_to_global[k][1];
        int k2 = map_local_to_global[k][2];
        int k3 = map_local_to_global[k][3];
        
        auto f_hat = [p1, p2, p3, f] (float csi, float eta) {
            return f(p1.x + csi*(p2.x - p1.x) + eta*(p3.x - p1.x),
                     p1.y + csi*(p2.y - p1.y) + eta*(p3.y - p1.y));
        };
        
        auto g1 = [f_hat](float csi, float eta) {
            return f_hat(csi, eta) * (1 - csi - eta);
        };
        
        auto g2 = [f_hat](float csi, float eta) {
            return f_hat(csi, eta) * csi;
        };
        
        auto g3 = [f_hat](float csi, float eta) {
            return f_hat(csi, eta) * eta;
        };
        
        S_triangles[k] = Area(tris[k]);
        
        
//        float a = 2*S_triangles[k] * Gauss2D(g1);
//        float b = 2*S_triangles[k] * Gauss2D(g2);
//        float c = 2*S_triangles[k] * Gauss2D(g3);
        
        if (!is_in_bound[k1]) {
            F[k1] += 2*S_triangles[k] * Gauss2D(g1);
        }
        if (!is_in_bound[k2]) {
            F[k2] += 2*S_triangles[k] * Gauss2D(g2);
        }
        if (!is_in_bound[k3]) {
            F[k3] += 2*S_triangles[k] * Gauss2D(g3);
        }
    }
    
    
//    for (int i = 0; i < n_in; i++) {
//        cout << i << " " << F[i] << endl;
//    }
    
    cout << "Times: " << float( clock () - begin_time ) /  CLOCKS_PER_SEC << endl << endl;
    begin_time = clock();
    
    // Buoc 3: Tinh ma tran B
    
    cout << "Buoc 3: Tinh ma tran B" << endl;
    
    // Buoc 3.1: Tinh Phi, Gradient_Phi
//    SparseMatrix<float> B(n_in + 1);
    
    map<pair<int, int>, float> B;
    
    int n_b_cgm = 0;
    
    
//    cout << "n_in = " << n_in << endl;
    
    for (int k = 0; k < tris.size(); k++) {
        Point2D p1 = tris[k].p1;
        Point2D p2 = tris[k].p2;
        Point2D p3 = tris[k].p3;
        
        SparseMatrix<float> MT(3);
        MT.set(p1.x, 1, 1); MT.set(p1.y, 1, 2); MT.set(1, 1, 3);
        MT.set(p2.x, 2, 1); MT.set(p2.y, 2, 2); MT.set(1, 2, 3);
        MT.set(p3.x, 3, 1); MT.set(p3.y, 3, 2); MT.set(1, 3, 3);
        
        int k1 = map_local_to_global[k][1];
        int k2 = map_local_to_global[k][2];
        int k3 = map_local_to_global[k][3];
        
        vector<float> VP;
        vector<float> sol, sol_grad1, sol_grad2, sol_grad3;
        vector<float> temp1, temp2, temp3;
        
        // 1.
        if (!is_in_bound[k1]) {
            VP = {1, 0, 0};
            sol = solve(&MT, VP);
            sol_grad1 = {sol[0], sol[1]};
            temp1 = A->multiply(sol_grad1);
        }
        
        if (!is_in_bound[k2]) {
            VP = {0, 1, 0};
            sol = solve(&MT, VP);
            sol_grad2 = {sol[0], sol[1]};
            temp2 = A->multiply(sol_grad2);
        }
        
        if (!is_in_bound[k3]) {
            VP = {0, 0, 1};
            sol = solve(&MT, VP);
            sol_grad3 = {sol[0], sol[1]};
            temp3 = A->multiply(sol_grad3);
        }
        
        // 1, 1
        float K11, K12, K13, K21, K22, K23, K31, K32, K33;
        float b11, b12, b13, b21, b22, b23, b31, b32, b33;
        if (!is_in_bound[k1]) {
            K11 = S_triangles[k] * dot(temp1, sol_grad1);
//            b11 = B.get(k1 + 1, k1 + 1);
//            B.set(b11 + K11, k1 + 1, k1 + 1);
            
            b11 = B[make_pair(k1 + 1, k1 + 1)];
            B[MP(k1 + 1, k1 + 1)] = b11 + K11;
            
            if (!is_in_bound[k2]) {
                K12 = S_triangles[k] * dot(temp1, sol_grad2);
//                b12 = B.get(k1 + 1, k2 + 1);
//                B.set(b12 + K12, k1 + 1, k2 + 1);
                
                b12 = B[make_pair(k1 + 1, k2 + 1)];
                B[MP(k1 + 1, k2 + 1)] = b12 + K12;
            }
            if (!is_in_bound[k3]) {
                
                K13 = S_triangles[k] * dot(temp1, sol_grad3);
//                b13 = B.get(k1 + 1, k3 + 1);
//                B.set(b13 + K13, k1 + 1, k3 + 1);
                b13 = B[make_pair(k1 + 1, k3 + 1)];
                B[MP(k1 + 1, k3 + 1)] = b13 + K13;
            }
        }
        
        if (!is_in_bound[k2]) {
            K22 = S_triangles[k] * dot(temp2, sol_grad2);
//            b22 = B.get(k2 + 1, k2 + 1);
//            B.set(b22 + K22, k2 + 1, k2 + 1);
            b22 = B[make_pair(k2 + 1, k2 + 1)];
            B[MP(k2 + 1, k2 + 1)] = b22 + K22;
            
            if (!is_in_bound[k1]) {
                K21 = S_triangles[k] * dot(temp2, sol_grad1);
//                b21 = B.get(k2 + 1, k1 + 1);
//                B.set(b21 + K21, k2 + 1, k1 + 1);
                
                b21 = B[make_pair(k2 + 1, k1 + 1)];
                B[MP(k2 + 1, k1 + 1)] = b21 + K21;
            }
            if (!is_in_bound[k3]) {
                K23 = S_triangles[k] * dot(temp2, sol_grad3);
//                b23 = B.get(k2 + 1, k3 + 1);
//                B.set(b23 + K23, k2 + 1, k3 + 1);
                b23 = B[make_pair(k2 + 1, k3 + 1)];
                B[MP(k2 + 1, k3 + 1)] = b23 + K23;
            }
        }
        if (!is_in_bound[k3]) {
            K33 = S_triangles[k] * dot(temp3, sol_grad3);
//            b33 = B.get(k3 + 1, k3 + 1);
//            B.set(b33 + K33, k3 + 1, k3 + 1);
            
            b33 = B[make_pair(k3 + 1, k3 + 1)];
            B[MP(k3 + 1, k3 + 1)] = b33 + K33;
            if (!is_in_bound[k1]) {
                K31 = S_triangles[k] * dot(temp3, sol_grad1);
//                b31 = B.get(k3 + 1, k1 + 1);
//                B.set(b31 + K31, k3 + 1, k1 + 1);
                b31 = B[make_pair(k3 + 1, k1 + 1)];
                B[MP(k3 + 1, k1 + 1)] = b31 + K31;
            }
            if (!is_in_bound[k2]) {
                K32 = S_triangles[k] * dot(temp3, sol_grad2);
//                b32 = B.get(k3 + 1, k2 + 1);
//                B.set(b32 + K32, k3 + 1, k2 + 1);
                b32 = B[make_pair(k3 + 1, k2 + 1)];
                B[MP(k3 + 1, k2 + 1)] = b32 + K32;
            }
        }
    }
    
//    for (int i = 1; i <= n_in + 1; i++) {
//        for (int j = 1; j <= n_in + 1; j++) {
//            cout << B.get(i, j) << " ";
//        }
//        cout << endl;
//    }
    
//    cout << "Xong B" << endl;
    
    
    
    for (map<pair<int, int>, float>::iterator it = B.begin(); it != B.end(); ++it) {

        int x = it->first.first;
        int y = it->first.second;
        float val = it->second;
        
        if (abs(val) < 1e-8) continue;
        
        n_b_cgm++;
        B_CGM[n_b_cgm].x = x;
        B_CGM[n_b_cgm].y = y;
        B_CGM[n_b_cgm].value = val;
    }
    
    cout << "Times: " << float( clock () - begin_time ) /  CLOCKS_PER_SEC << endl << endl;
    begin_time = clock();
    
    cout << "Buoc 4: Dung CGM giai he. \n";
    
    vector<float> c = CGM(B_CGM, F, n_b_cgm);
    
    cout << "Times: " << float( clock () - begin_time ) /  CLOCKS_PER_SEC << endl << endl;
    begin_time = clock();

//    cout << "c = \n";
//    for (int i = 0; i < c.size(); i++) {
//        cout << c[i] << endl;
//    }
    
    cout << "Buoc 5: Tinh sai so. \n";

    float all_error = 0;
    
    for (int k = 0; k < tris.size(); k++) {
        Point2D p1 = tris[k].p1;
        Point2D p2 = tris[k].p2;
        Point2D p3 = tris[k].p3;
        int k1 = map_local_to_global[k][1];
        int k2 = map_local_to_global[k][2];
        int k3 = map_local_to_global[k][3];

        float a1 = 0;
        float a2 = 0;
        float a3 = 0;
        
        if (!is_in_bound[k1]) a1 = c[k1];
        if (!is_in_bound[k2]) a2 = c[k2];
        if (!is_in_bound[k3]) a3 = c[k3];
//        auto f_hat = [p1, p2, p3, f] (float csi, float eta) {
//            return f(p1.x + csi*(p2.x - p1.x) + eta*(p3.x - p1.x),
//                     p1.y + csi*(p2.y - p1.y) + eta*(p3.y - p1.y));
//        };
        auto u_real_hat = [p1, p2, p3] (float csi, float eta) {
            return u_real(p1.x + csi*(p2.x - p1.x) + eta*(p3.x - p1.x),
                    p1.y + csi*(p2.y - p1.y) + eta*(p3.y - p1.y));
        };
        
        auto u_N_hat = [a1, a2, a3] (float csi, float eta) {
            return a1*(1 - csi - eta) + a2*csi + a3*eta;
        };
        
        auto func = [u_real_hat, u_N_hat] (float csi, float eta) {
            float tmp = (u_real_hat(csi, eta) - u_N_hat(csi, eta));
            return tmp * tmp;
        };
        
        float val = 2*S_triangles[k]*Gauss2D(func);
        all_error += val;
    }
    all_error = sqrt(all_error);
    
    printf("All error: %0.10f\n", all_error);
    
    cout << "Times: " << float( clock () - begin_time ) /  CLOCKS_PER_SEC << endl << endl;
    begin_time = clock();
    
}


#endif /* FEMTwoDimens_h */
