#include<bits/stdc++.h>


using namespace std;

string s1, s2;

pair<int, int> p;

string add(string a, string b) {
    
    while (a.length() < b.length()) a = '0' + a;
    while (a.length() > b.length()) b = '0' + b;

    int r = 0;
    string res = "";
    for (int i = a.length() - 1; i >= 0; i--) {
        int num1 = a[i] - 48;
        int num2 = b[i] - 48;

        int num = num1 + num2 + r;


        r = num / 10;
        num = num % 10;
        
        char c = char(num + 48);


        res = c + res;
    }
    if (r > 0) res = char(r + 48) + res;
    return res;
}

int main() {
    
    p = {1, 5};

    cin >> s1;
    cin >> s2;

    cout << add(s1, s2) << endl;

    
}
