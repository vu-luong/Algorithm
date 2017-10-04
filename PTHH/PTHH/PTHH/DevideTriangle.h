//
//  DevideTriangle.h
//  PTHH
//
//  Created by luong anh vu on 10/22/16.
//  Copyright © 2016 luong anh vu. All rights reserved.
//

#ifndef DevideTriangle_h
#define DevideTriangle_h

#include "Constants.h"


using namespace std;


Point2D getTD(Point2D p1, Point2D p2) {
    
    return {(p1.x + p2.x) / 2, (p1.y + p2.y) / 2};
    
}

void devide(vector<Triangle> &old_tris, map<Point2D, int, Point2DCompare> &imap, bool bound_point[MAXM],
            int tri_map[MAXM][4]) {
    
    int old_m = old_tris.size();
    
    int new_m = 0;
    int new_n = imap.size();
    vector<Triangle> tris;
    
//    int tri_map[MAXM][4];
//    memset(tri_map, 0, sizeof tri_map);
    for (int i = 0; i <= old_m; i++) {
        for (int j = 1; j <= 3; j++) {
            tri_map[i][j] = 0;
        }
    }
    
    for (int i = 0; i < old_m; i++) {
        
        // Lay toa do cac dinh va cac trung diem
        Triangle tri = old_tris[i];
        Point2D p1 = tri.p1;
        Point2D p2 = tri.p2;
        Point2D p3 = tri.p3;
        
        Point2D td1 = getTD(p1, p2);
        Point2D td2 = getTD(p2, p3);
        Point2D td3 = getTD(p3, p1);
        
        // Luu cac dinh moi vao new_stt_dinh_map
        if (imap.count(td1) == 0) {
            new_n++;
            imap[td1] = new_n - 1;
        }
        
        if (imap.count(td2) == 0) {
            new_n++;
            imap[td2] = new_n - 1;
        }
        
        if (imap.count(td3) == 0) {
            new_n++;
            imap[td3] = new_n - 1;
        }
        
        // Kiem tra dinh nam tren bien
        
        int ip1 = imap[p1];
        int ip2 = imap[p2];
        int ip3 = imap[p3];
        
        int itd1 = imap[td1];
        int itd2 = imap[td2];
        int itd3 = imap[td3];
        
        bool b1 = (bound_point[ip1] == true);
        bool b2 = (bound_point[ip2] == true);
        bool b3 = (bound_point[ip3] == true);
        
        bound_point[itd1] = b1 && b2;
        bound_point[itd2] = b2 && b3;
        bound_point[itd3] = b3 && b1;
        
        // Them cac tam giac moi vao new_triangles
        
        // Tri 1
        
        new_m += 1;
        Triangle new_tri = {p1, td1, td3};
        tris.push_back(new_tri);
        tri_map[new_m - 1][1] = ip1;
        tri_map[new_m - 1][2] = itd1;
        tri_map[new_m - 1][3] = itd3;
        
        // Tri 2
        
        new_m += 1;
        new_tri = {td1, p2, td2};
        tris.push_back(new_tri);
        tri_map[new_m - 1][1] = itd1;
        tri_map[new_m - 1][2] = ip2;
        tri_map[new_m - 1][3] = itd2;
        
        // Tri 3
        
        new_m += 1;
        new_tri = {td3, td2, p3};
        tris.push_back(new_tri);
        tri_map[new_m - 1][1] = itd3;
        tri_map[new_m - 1][2] = itd2;
        tri_map[new_m - 1][3] = ip3;
        
        // Tri 4
        
        new_m += 1;
        new_tri = {td1, td2, td3};
        tris.push_back(new_tri);
        tri_map[new_m - 1][1] = itd1;
        tri_map[new_m - 1][2] = itd2;
        tri_map[new_m - 1][3] = itd3;
    }
    
    old_tris = tris;
    
}

#endif /* DevideTriangle_h */
