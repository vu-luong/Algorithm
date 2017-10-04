#include <bits/stdc++.h>

using namespace std;

int main() {

    int n = 200000;
    std::vector<int> v;

    for (int i = 1; i <= n; i++) {
        v.push_back(i);
    }

    std::random_device rd;
    std::mt19937 g(rd());

    std::shuffle(v.begin(), v.end(), g);

   // std::copy(v.begin(), v.end(), std::ostream_iterator<int>(std::cout, " "));
   // std::cout << "\n";


    freopen("D.txt", "w", stdout);

    cout << n << endl;

    for (int i = 1; i <= 3; i++ ){
        std::C rd;
        std::mt19937 g(rd());

        std::shuffle(v.begin(), v.end(), g);

        std::copy(v.begin(), v.end(), std::ostream_iterator<int>(std::cout, " "));
        std::cout << "\n";


    }
}
