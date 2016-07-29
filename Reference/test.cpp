#include <iostream>
#include <vector>

using namespace std;

int main() {

    vector<int> a(10);
    a.resize(15);

    cout << a.size() <<endl;

}
