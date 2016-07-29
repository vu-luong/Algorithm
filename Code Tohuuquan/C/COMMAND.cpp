#include <iostream>
using namespace std;

const int dx[] = { 0, 1, 0, -1 };
const int dy[] = { 1, 0, -1, 0 };

int main() {
    while (true) {
        string st;
        do getline(cin, st);
        while (st != "[CASE]" && st != "[END]");

        if (st == "[END]") break;

        string seq; getline(cin, st);
        while (getline(cin, st)) {
            if (st == ">>") break;
            seq += st;
        }

        int x = 0, y = 0, dir = 0;
        for (int loop = 0; loop < 4; loop++)
            for (int i = 0; i < seq.size(); i++)
                switch (seq[i]) {
                    case 'L' : dir = (dir + 3) % 4; break;
                    case 'R' : dir = (dir + 1) % 4; break;
                    case 'S' : x += dx[dir]; y += dy[dir]; break;
                }

        if (x == 0 && y == 0) printf("bounded\n");
        else printf("unbounded\n");
    }
}
