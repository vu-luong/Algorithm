#include <iostream>
#include <stack>
using namespace std;

string T;
stack <int> S;

int main() {
    while (getline(cin, T)) {
        if (T == "ENDPROGRAM") break;

        int f1 = 1, f2 = 0;
        bool flag = false;

        if (T == "IF") S.push(-1); else
        if (T == "ELSE") S.push(-2); else
        if (T == "END_IF") {
            while (S.top() != -1) {
                if (S.top() != -2) {
                    f1 *= S.top();
                    S.pop();
                    continue;
                }
                flag = true;
                f2 = f1; f1 = 1;
                S.pop();
                break;
            }

            while (S.top() != -1) f1 *= S.top(), S.pop();

            f1 += f2;
            S.pop();
            S.push(flag ? f1 : f1 + 1);
        }
    }

    int res = 1;
    while (S.size()) res *= S.top(), S.pop();

    printf("%d", res);
}
