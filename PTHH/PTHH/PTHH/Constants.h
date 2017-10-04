//
//  Constants.h
//  PTHH
//
//  Created by luong anh vu on 10/22/16.
//  Copyright © 2016 luong anh vu. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#include "cmath"
#include <functional>

const int MAXN = 5005;
const int MAXM = 6000000;
struct Point2D {
//    Point2D(): x(0), y(0) {}
//    Point2D(float newX, float newY): x(newX), y(newY) {}
    
    float x, y;
};

struct Point2DCompare
{
    bool operator() (const Point2D p1, const Point2D p2) const
    {
        return ((p1.x < p2.x) || (p1.x == p2.x && p1.y < p2.y));
    }
};
struct data{
    int x, y;
    float value;
};

struct Triangle {
    Point2D p1, p2, p3;
};

struct Element {
    float val;
    int x, y;
};

float dis(Point2D p1, Point2D p2) {
    return sqrt((p1.x - p2.x)*(p1.x - p2.x) + (p1.y - p2.y)*(p1.y - p2.y));
}

float u_real(float x, float y) {
    return x*y*(x - 1)*(y - 1);
}

float Area(Triangle tri) {
    float a = dis(tri.p1, tri.p2);
    float b = dis(tri.p2, tri.p3);
    float c = dis(tri.p3, tri.p1);
    
    float p = (a + b + c) / 2;
    
    return sqrt(p*(p - a)*(p - b)*(p - c));
}

float Gauss2D(function<float (float, float)> g) {
    return (0.5f)* ((9.0f/40) * g(1.0f/3, 1.0f/3)
    +((155 - sqrt(15)) / 1200)*g((6 - sqrt(15))*(1.0f/21), (1.0f/21)*(6 - sqrt(15)))
    +((155 - sqrt(15)) / 1200)*g((9 + 2*sqrt(15))*(1.0f/21), (6 - sqrt(15))*(1.0f/21))
    +((155 - sqrt(15)) / 1200)*g((6 - sqrt(15))*(1.0f/21), (9 + 2*sqrt(15))*(1.0f/21))
    +((155 + sqrt(15)) / 1200)*g((6 + sqrt(15))*(1.0f/21), (6 + sqrt(15))*(1.0f/21))
    +((155 + sqrt(15)) / 1200)*g((6 + sqrt(15))*(1.0f/21), (9 - 2*sqrt(15))*(1.0f/21))
    +((155 + sqrt(15)) / 1200)*g((9 - 2*sqrt(15))*(1.0f/21), (6 + sqrt(15))*(1.0f/21)));
}


#endif /* Constants_h */
