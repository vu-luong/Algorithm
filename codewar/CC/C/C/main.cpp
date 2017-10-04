#include <stdio.h>
#include <map>
#include <set>
#include <cmath>
#include <cstdio>
#include <vector>
#include <string>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <algorithm>

#define UNASSIGNED 0

#define N 9

using namespace std;

const int px[] = {1};
const int py[] = {1};
const int tx[] = {};
const int ty[] = {};


bool FindUnassignedLocation(int grid[N][N], int &row, int &col);

bool isSafe(int grid[N][N], int row, int col, int num);

bool SolveSudoku(int grid[N][N])
{
    int row, col;
    
    if (!FindUnassignedLocation(grid, row, col))
        return true; // success!
    
    for (int num = 1; num <= 9; num++)
    {
        // if looks promising
        if (isSafe(grid, row, col, num))
        {
            // make tentative assignment
            grid[row][col] = num;
            
            // return, if success, yay!
            if (SolveSudoku(grid))
                return true;
            
            // failure, unmake & try again
            grid[row][col] = UNASSIGNED;
        }
    }
    return false; // this triggers backtracking
}

/* Searches the grid to find an entry that is still unassigned. If
 found, the reference parameters row, col will be set the location
 that is unassigned, and true is returned. If no unassigned entries
 remain, false is returned. */
bool FindUnassignedLocation(int grid[N][N], int &row, int &col)
{
    for (row = 0; row < N; row++)
        for (col = 0; col < N; col++)
            if (grid[row][col] == UNASSIGNED)
                return true;
    return false;
}

bool UsedInRow(int grid[N][N], int row, int num)
{
    for (int col = 0; col < N; col++)
        if (grid[row][col] == num)
            return true;
    return false;
}

/* Returns a boolean which indicates whether any assigned entry
 in the specified column matches the given number. */
bool UsedInCol(int grid[N][N], int col, int num)
{
    for (int row = 0; row < N; row++)
        if (grid[row][col] == num)
            return true;
    return false;
}

/* Returns a boolean which indicates whether any assigned entry
 within the specified 3x3 box matches the given number. */
bool UsedInBox(int grid[N][N], int boxStartRow, int boxStartCol, int num)
{
    for (int row = 0; row < 3; row++)
        for (int col = 0; col < 3; col++)
            if (grid[row+boxStartRow][col+boxStartCol] == num)
                return true;
    return false;
}

/* Returns a boolean which indicates whether it will be legal to assign
 num to the given row,col location. */
bool isSafe(int grid[N][N], int row, int col, int num)
{
    return !UsedInRow(grid, row, num) &&
    !UsedInCol(grid, col, num) &&
    !UsedInBox(grid, row - row%3 , col - col%3, num);
}

void printGrid(int grid[N][N])
{
    for (int row = 0; row < N; row++)
    {
        for (int col = 0; col < N; col++)
            printf("%2d", grid[row][col]);
        printf("\n");
    }
}

string s;
int n[N][N];

int main()
{
    int grid[N][N] = {{0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0}};
    
    
    if (SolveSudoku(grid) == true)
        printGrid(grid);
    else
        printf("No solution exists");
    
    freopen("C.txt", "r", stdin);
    
    for (int k = 1; k <= 15; k++) {
        
        getline(cin, s);
        cout << s << endl;
        n[k][0] = 0;
        
        for (int i = 1; i < s.length(); i++) {
            if (s[i] == '<') {
                n[k][0]++;
                n[k][n[k][0]] = 1;
            } else
            if (s[i] == '>') {
                n[k][0]++;
                n[k][n[k][0]] = 2;
            } else
            if (s[i] == 'v') {
                n[k][0]++;
                n[k][n[k][0]] = 4;
            } else {
                if (s[i] != '|' && s[i] != ' ' && s[i] != '\312') {
                    n[k][0]++;
                    n[k][n[k][0]] = 3;
//                    cout << "s[i] = " << '\312' << endl;
                }
            }
        }
        
        for (int i = 1; i <= n[k][0]; i++) {
            cout << n[k][i] << " ";
        }
        cout << endl;
        
    }
    
    for (int i = 1; i <= 9; i++) {
        if (i == 3 || i == 6) {
            
        }
    }
    
    
    return 0;
}
