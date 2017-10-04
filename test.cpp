#include<iostream>
#include<map>


// g++ test.cpp --std=c++11
#include <functional>
#include <tuple>

using namespace std;


double Combiner(double a, double b, function<double (double,double)> func){
  return func(a,b);
}

double Add(double a, double b){
  return a+b;
}

double Mult(double a, double b){
  return a*b;
}

int main(){
//  cout << Combiner(12,13,Add) << endl;
//  cout << Combiner(12,13,Mult) << endl;

    
    int a[5];
    a[1] = 2;
    a[2] = 3;
    a[3] = 5;
    a[4] = 6;

    int first = 0;
    int last = 5;
    
    
    while (first + 1 < last) {
        int mid = (first + last) / 2;
        if (a[mid] <= 6) {
            first = mid;
        } else {
            last = mid;
        }
    }

    cout << first << endl;
}
